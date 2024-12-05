local http = assert(require 'http')
local executeRequest = true
local pin = ""
local webservice_address = "http://192.168.1.29" 


function sendRequest(requestType, uri, body)

	print(("Fetching %s..."):format(uri))

	-- Configuração da requisição HTTP
	local headers = {
		["Content-Type"] = "application/json"
	}

	local status, code, responseHeaders, responseBody

	if requestType == "post" then
		-- Envia a requisição HTTP POST
		status, code, responseHeaders, responseBody = http.post(uri, headers, body)
	elseif requestType == "get" then
		-- Envia a requisição HTTP GET
	   status, code, responseHeaders, responseBody = http.get(uri, headers, body)
	end
	-- Exibe o corpo da resposta
	print("Corpo:")
	print(responseBody or "Sem conteúdo")
	return responseBody
	

end

function sendRequest2(requestType, uri, body)

	print(("Fetching %s..."):format(uri))

	-- Configuração da requisição HTTP
	local headers = {
		["Content-Type"] = "application/json"
	}

	local status, code, responseHeaders, responseBody

	if requestType == "post" then
		-- Envia a requisição HTTP POST
		status, code, responseHeaders, responseBody = http.post(uri, headers, body)
	elseif requestType == "get" then
		-- Envia a requisição HTTP GET
	   status, code, responseHeaders, responseBody = http.get(uri, headers, body)
	end
	-- Exibe o corpo da resposta
	print("Corpo:")
	print(responseBody or "Sem conteúdo")
	--print(responseBody["pin"])
	print(string.find(responseBody, "pin"))

	for i = 1, #responseBody do
		local char = string.sub(responseBody, i, i)
		print("Índice: " .. i, "Caractere: " .. char)
		
		if i >= 9 and i <= 12 then
			pin = pin .. char
		end
		
	end
	
	print(pin)

end

function handler(evt)
    if evt.type == 'presentation' and evt.action == 'start' then
        print("evento de apresentacao ncl")
    elseif evt.type == 'attribution' and evt.action == 'start' and evt.name == "createRoom" then
	
			local body = '{ "url": "http://192.168.1.29", "level": "highSchool" }' -- Corpo da requisição
			local co = coroutine.create(sendRequest2)
			local status, thread, result = coroutine.resume(co, "post", "https://cursa.eic.cefet-rj.br/eduweb/create-room", body)

    elseif evt.type == 'attribution' and evt.action == 'start' and evt.name == "startQuestion" then
			local body
			local co = coroutine.create(sendRequest)
			local url = ("https://cursa.eic.cefet-rj.br/eduweb/" .. "start-question/" .. pin )
			local status, err = coroutine.resume(co, "get", url, body)
			print(url)
    end
end

event.register(handler, 'ncl')
