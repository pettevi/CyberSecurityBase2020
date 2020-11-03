from django.http import HttpResponse
from django.template import loader
from django.shortcuts import render
from django.http import Http404
from django.shortcuts import get_object_or_404, render
import random

from .models import Question, Quote
from .forms import NameForm

def index(request):
    latest_question_list = Question.objects.order_by('-pub_date')[:5]
    context = {'latest_question_list': latest_question_list}
    return render(request, 'polls/index.html', context)

def results(request, question_id):
    response = "You're looking at the results of question %s."
    return HttpResponse(response % question_id)

def vote(request, quote_id):
    quote = Quote.objects.get(id=quote_id)
    quote.votes += 1
    quote.save()

    content = build_reply(quote_id)

    return render(request, 'polls/tintin.html', {'quote': content})
#    return HttpResponse("You're voting on question %s." % question_id)
    
def detail(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    return render(request, 'polls/detail.html', {'question': question})

def tintin(request, quote_id = -1):
    if quote_id >= 0:
        content = build_reply(quote_id)
    elif request.method == 'GET':
        char = request.GET.get('char')
        if char == 'Random' or char == None:
            content = build_reply(quote_id)
        else:
            content = build_reply_for_char(char)
    else:
        content = build_reply(quote_id)
    return render(request, 'polls/tintin.html', {'quote': content})

def color():
    return str(random.randint(200, 255))

def build_reply_for_char(char):

    quote = Quote.objects.raw('SELECT * FROM polls_quote WHERE character_name == %s', [char])
#    print( "DEBUG " + str(quote) + str(len(list(quote))))

    l = len(list(quote))
    ran = random.randint(0, l-1)
    quote_text = quote[ran]
    
    name = quote_text.character_name
    book = quote_text.book_name
    x1 = str(random.randint(50, 450))
    y1 = str(random.randint(30, 110))
    x2 = str(random.randint(0, 170))
    y2 = str(random.randint(0, 50))
    image = get_image(name)
    votes = quote_text.votes;
    id = quote_text.id;
    content = {'text': quote_text, 'bgcolor': "rgb(" + color() + "," + color() + "," + color() + ")", 'name': name, 'book': book, 'image': image, 'x1': x1, 'y1': y1, 'x2': x2, 'y2': y2, 'votes': votes, 'id': id}

    return content


def build_reply(quote_id):
    if quote_id < 0:
        quote_text = Quote.objects.order_by("?").first()
    else:
        quote_text = Quote.objects.get(id=quote_id)
        
    name = quote_text.character_name
    book = quote_text.book_name
    x1 = str(random.randint(50, 450))
    y1 = str(random.randint(30, 110))
    x2 = str(random.randint(0, 170))
    y2 = str(random.randint(0, 50))
    image = get_image(name)
    votes = quote_text.votes;
    id = quote_text.id;
    content = {'text': quote_text, 'bgcolor': "rgb(" + color() + "," + color() + "," + color() + ")", 'name': name, 'book': book, 'image': image, 'x1': x1, 'y1': y1, 'x2': x2, 'y2': y2, 'votes': votes, 'id': id}

    return content


def get_image(name):
    if name == 'Tintin':
        if random.getrandbits(1) == 0:
            return 'tintin'
        else:
            return 'tintin2'
    elif name == 'Captain Haddoc':
        if random.getrandbits(1) == 0:
            return 'haddock'
        else:
            return 'haddock2'
    elif name == 'Snowy':
        return 'snowy'
    elif name == 'Bianca Castafiore':
        return 'castafiore'
    elif name == 'Professor Calculus':
        return 'calculus'
    elif name == 'Thomson and Thompson':
        return 'detectives'
