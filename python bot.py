import requests
import telebot
import webbrowser

weather_api = ('https://api.openweathermap.org/data/2.5/weather?lat=43.222015&lon=76.851250&appid='
               '663a6cb2f9b002395a4f35791f544bb1')
bot = telebot.TeleBot('6912196792:AAGlm9852NxDPUflLMnY9vtnFrgsEGcHsPg')


def get_weather():
    response = requests.get(weather_api)
    if response.status_code == 200:
        data = response.json()
        weather = data['weather'][0]['description']
        temp = data['main']['temp']
        return f"The weather in Almaty is {weather} with a temperature of {temp}°C."
    else:
        return "Sorry, I couldn't fetch the weather data."


@bot.message_handler(commands=['weather'])
def get_weather(message):
    weather_update = get_weather()
    bot.send_message(message.chat.id, weather_update)


@bot.message_handler(commands=['site', 'website'])
def site():
    webbrowser.open('https://www.porsche.com/usa/models/taycan/taycan-models/taycan/')


@bot.message_handler(commands=['start'])
def main(message):
    bot.send_message(message.chat.id, f'Hello,  {message.from_user.last_name} {message.from_user.first_name}')

t.message_handler(commands=['help'])
def main(message):
    bot.send_message(message.chat.id, 'Help information')


@bot.message_handler()
def info(message):
    if message.text.lower() == 'hello':
        bot.send_message(message.chat.id, f'Hello,  {message.from_user.last_name} {message.from_user.first_name}')
    elif message.text.lower() == 'id':
        bot.message_handler(message, f'ID: {message.from_user.id}')


bot.infinity_polling()
