# Biblioteca ColorPicker

ColorPicker é uma biblioteca Lua projetada para fornecer uma funcionalidade simples e interativa de seleção de cores para seus projetos. Com o ColorPicker, você pode integrar facilmente um recurso de seleção de cores em suas aplicações ou jogos.

## Recursos

- **Interface Interativa**: Os usuários podem selecionar cores clicando na paleta de cores.
- **Paleta Personalizável**: Configure facilmente uma imagem de paleta personalizada para combinar com o design de sua aplicação.
- **Recuperação Eficiente de Cores**: Recupere a cor selecionada com ajuste opcional de opacidade.

## Instalação

Para usar o ColorPicker em seu projeto Lua, simplesmente inclua o arquivo `ColorPicker.lua` em seu diretório de projeto e o requisite em seu código.

1. Adicione o arquivo `colorpicker.lua` em seu sript;
2. Caso o método `oop` não esteja habilitado, use adicione o código abaixo:
```xml
<oop>true</oop>
```
3. Em meta.xml adicione o código para seu script reconhecer a biblioteca:
```xml
<script src='colorpicker.lua' type='client' cache='false' />
```

## Uso

### Criando um Objeto ColorPicker

```lua
local imagemPaleta = "paleta.png"
local paleta = ColorPicker.new(imagemPaleta)
```

### Desenhando o ColorPicker

```lua
function onRender()
    paleta:draw(x, y, largura, altura)
end
```

### Obtendo a Cor Selecionada

```lua
local r, g, b = paleta:getColor()
```

### Personalizando a Paleta

```lua
local novaImagemPaleta = "nova_paleta.png"
paleta:setPallet(novaImagemPaleta)
```

### Destruindo o ColorPicker

```lua
paleta:destroy()
```

## Exemplo

```lua
local screen = Vector2(guiGetScreenSize())

local pallet = ColorPicker.new('colorpalette.png')

local palletX, palletY = screen.x / 2, screen.y / 2

addEventHandler('onClientRender', root, function()
    pallet:draw(palletX, palletY, 200, 200)

    local r, g, b = pallet:getColor()
    dxDrawText('R: ' .. r .. '\nG: ' .. g .. '\nB: ' .. b, palletX, palletY)
end)
```

## Licença

Esta biblioteca é licenciada sob a Licença MIT. Consulte o arquivo [LICENSE](LICENSE) para obter detalhes.

---

Sinta-se à vontade para personalizar e integrar a biblioteca ColorPicker em seus projetos. Se encontrar problemas ou tiver sugestões para melhorias, não hesite em [reportá-los](https://github.com/yourusername/ColorPicker/issues).
