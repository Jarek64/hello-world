from flask import Flask

import smarties

app = Flask(__name__)

@app.route('/hello/', methods=['GET', 'POST'])
def welcome():
    return "Hello World!"

@app.route('/smarties/', methods=['GET', 'POST'])
def smarties_getpost():
    return smarties.color

@app.route('/smarties/colors/', methods=['GET', 'POST'])
def colors():
    return smarties.color

@app.route('/smarties/flavors/<flavor_name>', methods=['GET', 'POST'])
def flavorname(flavor_name):
    if flavor_name not in smarties.flavor:
        return "Wrong flavor silly", 404
    color_name = smarties.flavor_to_color[flavor_name]
    return {
            
            "color_name":color_name,
            }

@app.route('/smarties/colors/<color_name>', methods=['GET', 'POST'])
def colorname(color_name):
    if color_name not in smarties.color:
        return "Wrong color silly", 404
    flavor_name = smarties.color_to_flavor[color_name]
    return {
            
            "flavor_name":flavor_name,
            }



if __name__ == '__main__':
    app.run(host='0.0.0.0', port=105)