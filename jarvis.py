import pyttsx3
import datetime
import speech_recognition as sr
import wikipedia
import webbrowser
import os

engine = pyttsx3.init('sapi5')
voices=engine.getProperty('voices')
#print (voices) gives the no of voices present in the system
#print (voices[0].id) gives info about present voice at index 0(we have 2 voices 0=male,1=female)

def speak(audio):
    engine.say(audio) 
    engine.runAndWait() #Without this command, speech will not be audible to us.

def wishMe():
    #Gives greetings of the day and introduce one self
    hour=int(datetime.datetime.now().hour)
    if hour>=0 and hour<12:
        speak("Good Morning Siyona!")
    elif hour>=0 and hour<18:
        speak("Good Afternoon Siyona!")
    else:
        speak("Good Evening Siyona")
    speak("I am Jarvis,Please tell me how may I help you")

def takeCommand():
    #It takes microphone input from the user and returns string output

    r = sr.Recognizer() #This class helps us to recognise our audio
    with sr.Microphone() as source:
        print("Listening...")
        r.pause_threshold = 1 #threshold=seconds of non speaking audio before a phase is considered complete(means i can take a gap of 1 sec while speaking)
        audio = r.listen(source)
    
    try:
        print("Recognizing...")    
        query = r.recognize_google(audio, language='en-in') #Using Google Speech Recognition API to convert the spoken audio (audio variable) into text.
        print(f"User said: {query}\n")  #User query will be printed.

    except Exception as e:
        # print(e)    
        print("Say that again please...")   #Say that again will be printed in case of improper voice 
        return "None" #None string will be returned
    return query

if __name__=="__main__":
    wishMe()
    while True:
    # if 1:
        query = takeCommand().lower() #Converting user query into lower case

        # Logic for executing tasks based on query
        if 'open notepad' in query: #not working
            npath="C:\\Program Files\\WindowsApps\\Microsoft.WindowsNotepad_11.2406.9.0_x64__8wekyb3d8bbwe\\Notepad"
            os.startfile(npath)
        if 'wikipedia' in query:  #if wikipedia found in the query then this block will be executed
            speak('Searching Wikipedia...')
            query = query.replace("wikipedia", "")
            results = wikipedia.summary(query, sentences=2) 
            speak("According to Wikipedia")
            print(results)
            speak(results)
        elif 'open youtube' in query:
            webbrowser.open("youtube.com")
        elif 'open google' in query:
            webbrowser.open("google.com")
        elif 'i love you jarvis' in query:
            speak("I love you tooo!")
        elif 'the time' in query:
            strTime = datetime.datetime.now().strftime("%H:%M:%S")    
            speak(f"Ma'am, the time is {strTime}")
        elif 'open vs code' in query:
            codePath ="C:\\Users\\dell\\AppData\\Local\\Programs\\Microsoft VS Code\\Code.exe"
            os.startfile(codePath)
        elif 'gpt' in query:
            webbrowser.open("chatgpt.com")
        elif 'quit' or 'exit' in query:
            speak("Goodbye Siyona!")
            break   
        elif 'play music' in query:
            play_music()