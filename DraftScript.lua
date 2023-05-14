function onload()
	self.setRotation({0, 0, 0})
localPosition = self.getPosition()
localRotation = {x = self.getRotation().x, y = self.getRotation().y, z = self.getRotation().z + 180}
cardToKeepLocalPosition = {x = localPosition.x + 1.7, y = localPosition.y + 1, z = localPosition.z - 2}
cardToPassLocalPosition = {x = localPosition.x - 1.7, y = localPosition.y + 1, z = localPosition.z - 2}

	local customBag = spawnObject({
	type = "Bag",
	position = {
		x = self.getPosition().x + 2.4,
		y = self.getPosition().y,
		z = self.getPosition().z + 2.4
		},
	scale = {1, 1, 1}
	})

function onRotate(spin, flip, player_color, old_spin, old_flip)
			changePositionToLocal(old_spin, spin)
end

function changePositionToLocal(old_spin, spin)
	if (old_spin == 0 and spin == 90) then
		localPosition.x = localPosition.x - 3
		localPosition.z = localPosition.z - 0.28
		localRotation.y = localRotation.y + 90
		cardToKeepLocalPosition.x = cardToKeepLocalPosition.x - 3.6
		cardToKeepLocalPosition.z = cardToKeepLocalPosition.z + 0.4
		cardToPassLocalPosition.x = cardToPassLocalPosition.x - 0.25
		cardToPassLocalPosition.z = cardToPassLocalPosition.z + 3.7
	elseif (old_spin == 90 and spin == 180) then
		localPosition.x = localPosition.x - 0.2
		localRotation.y = localRotation.y + 90
		cardToKeepLocalPosition.x = cardToKeepLocalPosition.x + 0.4
		cardToKeepLocalPosition.z = cardToKeepLocalPosition.z + 3.6
		cardToPassLocalPosition.x = cardToPassLocalPosition.x + 3.7
		cardToPassLocalPosition.z = cardToPassLocalPosition.z + 0.25
	elseif (old_spin == 180 and spin == 270) then
		localPosition.x = localPosition.x + 4.2
		localRotation.y = localRotation.y + 90
		cardToKeepLocalPosition.x = cardToKeepLocalPosition.x + 3.6
		cardToKeepLocalPosition.z = cardToKeepLocalPosition.z - 0.4
		cardToPassLocalPosition.x = cardToPassLocalPosition.x + 0.25
		cardToPassLocalPosition.z = cardToPassLocalPosition.z - 3.7
	elseif (old_spin == 270 and spin == 0) then
		localPosition.x = localPosition.x + 0.2
		cardToKeepLocalPosition.x = cardToKeepLocalPosition.x - 0.4
		cardToKeepLocalPosition.z = cardToKeepLocalPosition.z - 3.6
		cardToPassLocalPosition.x = cardToPassLocalPosition.x - 3.7
		cardToPassLocalPosition.z = cardToPassLocalPosition.z - 0.25
		localRotation.y = 0
	elseif (old_spin == 0 and spin == 270) then
		localPosition.x = localPosition.x - 0.1
		localPosition.z = localPosition.z + 0.3
		localRotation.y = localRotation.y - 90
		cardToKeepLocalPosition.x = cardToKeepLocalPosition.x + 0.4
		cardToKeepLocalPosition.z = cardToKeepLocalPosition.z + 3.6
		cardToPassLocalPosition.x = cardToPassLocalPosition.x + 3.7
		cardToPassLocalPosition.z = cardToPassLocalPosition.z + 0.25
	elseif (old_spin == 270 and spin == 180) then
		localPosition.x = localPosition.x + 0.2
		localRotation.y = localRotation.y - 90
		cardToKeepLocalPosition.x = cardToKeepLocalPosition.x - 3.6
		cardToKeepLocalPosition.z = cardToKeepLocalPosition.z + 0.4
		cardToPassLocalPosition.x = cardToPassLocalPosition.x - 0.25
		cardToPassLocalPosition.z = cardToPassLocalPosition.z + 3.7
	elseif (old_spin == 180 and spin == 90) then
		localPosition.x = localPosition.x - 0.1
		localRotation.y = localRotation.y - 90
		cardToKeepLocalPosition.x = cardToKeepLocalPosition.x - 0.4
		cardToKeepLocalPosition.z = cardToKeepLocalPosition.z - 3.6
		cardToPassLocalPosition.x = cardToPassLocalPosition.x - 3.7
		cardToPassLocalPosition.z = cardToPassLocalPosition.z - 0.25
	elseif (old_spin == 90 and spin == 0) then
		localPosition.x = localPosition.x - 0.2
		cardToKeepLocalPosition.x = cardToKeepLocalPosition.x + 3.6
		cardToKeepLocalPosition.z = cardToKeepLocalPosition.z - 0.4
		cardToPassLocalPosition.x = cardToPassLocalPosition.x + 0.25
		cardToPassLocalPosition.z = cardToPassLocalPosition.z - 3.7
		localRotation.y = 0
	end
end

	customBag.setColorTint({1, 1, 1})
	
	local button_parameters = {}
	button_parameters.click_function = "onClick_divideDeal"
	button_parameters.function_owner = self
	button_parameters.label = 'Разделить\\nкарты'
	button_parameters.position = {0.75, 0.3, 1.3}
	button_parameters.rotation = {0, 0, 0}
	button_parameters.width = 900
	button_parameters.height = 500
	button_parameters.font_size = 100
	self.createButton(button_parameters)
	
	deal = getObjectFromGUID(customBag.getGUID())
	
	local keepCardsDescription_parameters = {}
	keepCardsDescription_parameters.click_function = "alert"
	keepCardsDescription_parameters.function_owner = self
	keepCardsDescription_parameters.label = 'Оставить'
	keepCardsDescription_parameters.position = {-0.85, 0.3, 0}
	keepCardsDescription_parameters.rotation = {0, 0, 0}
	keepCardsDescription_parameters.width = 0
	keepCardsDescription_parameters.height = 0
	keepCardsDescription_parameters.font_size = 100
	keepCardsDescription_parameters.font_color = {255, 0, 0}
	self.createButton(keepCardsDescription_parameters)
	
	local passCardsDescription_parameters = {}
	passCardsDescription_parameters.click_function = "alert"
	passCardsDescription_parameters.function_owner = self
	passCardsDescription_parameters.label = 'Передать'
	passCardsDescription_parameters.position = {0.85, 0.3, 0}
	passCardsDescription_parameters.rotation = {0, 0, 0}
	passCardsDescription_parameters.width = 0
	passCardsDescription_parameters.height = 0
	passCardsDescription_parameters.font_size = 100
	passCardsDescription_parameters.font_color = {0, 255, 0}
	self.createButton(passCardsDescription_parameters)
	
	function alert()
	return true
	end
end

function onClick_divideDeal()
  if isBagEmpty(deal) then
	print("Положите карты в мешочек")
    return
  end
  math.randomseed(os.time())
  pickCardFromDeal()
end

function dump(o)
	if type(o) == 'table' then
		local s = '{ '
			for k,v in pairs(o) do
				if type(k) ~= 'number' then k = '"'..k..'"' end
					s = s .. '['..k..'] = ' .. dump(v) .. ','
				end
			return s .. '} '
		else
			return tostring(o)
		end
end

function pickCardFromDeal()
	if haveMultipleCards(deal) then
		print("Достаньте карты из мешочка, объедините их в одну колоду и положите обратно")
		return
	elseif isLastDeal(deal) then
		local takenCard = deal.takeObject({
			position = cardToKeepLocalPosition,
			rotation = localRotation,
			smooth = false
			})
			--print("Deal is last!")
			return
	end
	--print("Deal is not last!")
    local deck = deal.takeObject()
	local quantity = deck.getQuantity()
	deck.shuffle()
	for _, containedCard in ipairs(deck.getObjects()) do
		if haveRarePlus(deck) then
			--print("Получена редкая/ультраредкая карта", dump(containedCard.guid))
			local rarePlusID = getRarePlusID(deck)
			--print("ID редкой/ультраредкой карты:", dump(rarePlusID))
			local cardToKeep = deck.takeObject({
			position = cardToKeepLocalPosition,
			guid = rarePlusID,
			rotation = localRotation,
			smooth = false
			})
			break
		else
		--print("Получена не ультра-редкая карта", dump(containedCard.guid))
			local cardToKeep = deck.takeObject({
				position = cardToKeepLocalPosition,
				guid = containedCard.guid,
				rotation = localRotation,
				smooth = false
			})
			break
		end
	end
	for i = 1, quantity - 1 do
		local cardToPass = deck.takeObject({
		position =	cardToPassLocalPosition,
			rotation = localRotation,
			smooth = false
		})
	end
end

function isBagEmpty(bag)
  return bag.getData().ContainedObjects == nil
end

function isLastDeal(deal)
		local additionalCardPresence = deal.getData().ContainedObjects[1].ContainedObjects
	return additionalCardPresence == nil
end

function haveMultipleCards(deal)
	return deal.getQuantity() > 1
end

function haveRarePlus(deck)
	local cards = deck.getObjects()
	for _, containedCard in ipairs(cards) do
		for _, tag in ipairs(containedCard.tags) do
			--print("Функция проверки на ультраредкую карту запущена")
			if tag == "Ультраредкая" or tag == "Редкая" then
				return true
			end
		end
	end
	return false
end

function getRarePlusID(deck)
	local cards = deck.getObjects()
	for _, containedCard in ipairs(cards) do
		for _, tag in ipairs(containedCard.tags) do
			--print("Функция поиска ID ультраредкой карты запущена")
			if tag == "Ультраредкая" or tag == "Редкая" then
				return containedCard.guid
			end
		end
	end
end

-- ToDo: добавить функцию объединения объектов карт и колод внутри Bag
