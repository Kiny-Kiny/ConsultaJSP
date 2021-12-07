from requests import get

for i in get({1:'http://cnes.datasus.gov.br/services/profissionais?nome=CARLOS%20ALBERTO',2:'http://cnes.datasus.gov.br/services/profissionais?cpf=00000000272'}[1], headers={"User-Agent": "Mozilla/5.0 (Android 10; Mobile; rv:94.0) Gecko/94.0 Firefox/94.0","Referer": "http://cnes.datasus.gov.br/pages/profissionais/consulta.jsp"}).json():
    for k,v in i.items():
        print(k,':',v)
    print('--------------------')
