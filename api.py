from flask import Flask, json, jsonify

##init app 
app = Flask(__name__)

## Data
file = open('cid-todos.json')
cid_complete = json.load(file)

@app.route('/')
def index():
    return 'Para retornar todas as doenças: /cid10. Para retornar codigo específico /cid10/codigo'

@app.route('/cid10')
def return_all():
    return cid_complete

@app.route('/cid10/<codigo>')
def return_code(codigo):
    codigo_value = codigo
    result_filtered = [d for d in cid_complete['cid10'] if d['codigo'] == codigo_value]
    return jsonify(result_filtered)


if __name__ == '__main__':
    app.run(debug=True)

