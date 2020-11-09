from django.urls import path

from . import views

app_name = 'polls'
urlpatterns = [
    path('', views.tintin, name='tintin'),
    path('tintin/', views.tintin, name='tintin'),
    path('tintin/dump', views.dump, name='dump'),
    path('tintin/contact', views.contact, name='contact'),
    path('tintin/note', views.note, name='note'),
    path('tintin/<int:quote_id>', views.tintin, name='tintin'),
    path('tintin/vote/<int:quote_id>', views.vote, name='vote'),
]