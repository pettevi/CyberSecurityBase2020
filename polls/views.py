from django.http import HttpResponse
from django.template import loader
from django.shortcuts import render
from django.http import Http404
from django.shortcuts import get_object_or_404, render
import random
import sqlite3

from .models import Question, Quote, Note
from .forms import NameForm

def index(request):
    latest_question_list = Question.objects.order_by('-pub_date')[:5]
    context = {'latest_question_list': latest_question_list}
    return render(request, 'polls/index.html', context)

def results(request, question_id):
    response = "You're looking at the results of question %s."
    return HttpResponse(response % question_id)

def dump(request):
    quotes = Quote.objects.raw("SELECT * FROM polls_quote")

    content = "<table>"
    for quote in quotes:
        content += "<tr>"
        content += "<td>" + str(quote.id) + "</td>"
        content += "<td>" + quote.character_name + "</td>"
        content += "<td>" + quote.quote_text + "</td>"
        content += "<td>" + quote.book_name + "</td>"
        content += "<td>" + str(quote.votes) + "</td>"
        content += "</tr>"

    content += "</table>"

    return HttpResponse(content)

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

def contact(request):
    return render(request, 'polls/contact.html')

def note(request):
    if request.method == 'POST':
        user_message = request.POST['message']
        user_name = request.POST['name']
        new_note = Note.objects.create(note=user_message, name=user_name)
        #new_note.save()

    return render(request, 'polls/note.html', { 'all_messages': Note.objects.all() } )

def color():
    return str(random.randint(200, 255))

def build_reply_for_char(char):

#    print( "DEBUG: " + str(char))
#    quote = Quote.objects.raw("SELECT * FROM polls_quote WHERE character_name = %s", [char])
#    print( "DEBUG: " + str(quote) + str(len(list(quote))))
    
    conn = sqlite3.connect("db.sqlite3")
    cursor = conn.cursor()
    response = cursor.execute("SELECT * FROM polls_quote WHERE character_name = ?", (char,))
    ukot = response.fetchall()

    i = random.randint(0, len(ukot)-1)
    print("DEBUG: random=" + str(i))

    print( "DEBUG: id=" + str(ukot[i][0]))
    print( "DEBUG: quote=" + str(ukot[i][1]))
    print( "DEBUG: char=" + str(ukot[i][2]))
    print( "DEBUG: book=" + str(ukot[i][3]))
    print( "DEBUG: votes=" + str(ukot[i][4]))

    id = ukot[i][0]
    quote_text = ukot[i][1]
    name = ukot[i][2]
    book = ukot[i][3]
    votes = ukot[i][4]

#    size = len(list(quote))
#    print( "DEBUG: size=" + str(size))
 #   if (size > 0):
#    ran = random.randint(0, size-1)
#    quote_text = quote[ran]
 #   else:
 #       ran = 0
 #       quote_text = Quote.objects.get(id=1)

#    name = quote_text.character_name
#    book = quote_text.book_name
    x1 = str(random.randint(50, 450))
    y1 = str(random.randint(30, 110))
    x2 = str(random.randint(0, 170))
    y2 = str(random.randint(0, 50))
    image = get_image(name)
#    votes = quote_text.votes;
#    id = quote_text.id;
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
