from django.urls import path

from . import views

app_name = 'polls'
urlpatterns = [
    path('', views.index, name='index'),
    path('<int:question_id>/', views.detail, name='detail'),
    path('<int:question_id>/results/', views.results, name='results'),
    path('<int:question_id>/vote/', views.vote, name='vote'),
    path('tintin/', views.tintin, name='tintin'),
    path('tintin/dump', views.dump, name='dump'),
    path('tintin/contact', views.contact, name='contact'),
    path('tintin/<int:quote_id>', views.tintin, name='tintin'),
    path('tintin/vote/<int:quote_id>', views.vote, name='vote'),
]