
if GetLocale() ~= "esES" then return end

local media = LibStub("LibSharedMedia-3.0")

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT101 = {name = "Da\195\177o Cuerpo a Cuerpo", tooltipText = "Muestra tu da\195\177o cuerpo a cuerpo"};
SCT.LOCALS.OPTION_EVENT102 = {name = "Da\195\177o Peri\195\179dico", tooltipText = "Muestra tu da\195\177o peri\195\179dico"};
SCT.LOCALS.OPTION_EVENT103 = {name = "Da\195\177o de Hechizo/Habilidad", tooltipText = "Muestra tu da\195\177o de hechizo y habilidad"};
SCT.LOCALS.OPTION_EVENT104 = {name = "Da\195\177o de la Mascota", tooltipText = "Muestra el da\195\177o causado por tu mascota"};
SCT.LOCALS.OPTION_EVENT105 = {name = "Colorear Cr\195\173ticos", tooltipText = "Muestra tus cr\195\173ticos con el color seleccionado"};
SCT.LOCALS.OPTION_EVENT106 = {name = "Interrupciones", tooltipText = "Muestra un mensaje cuando causas la interrupci\195\179n de un hechizo"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK101 = { name = "Activar SCTD", tooltipText = "Determina si se activa SCT - Damage"};
SCT.LOCALS.OPTION_CHECK102 = { name = "Marcar Da\195\177o", tooltipText = "Determina si se rodea todo el da\195\177o con un *"};
SCT.LOCALS.OPTION_CHECK103 = { name = "Tipo de Hechizo", tooltipText = "Muestra el tipo de da\195\177o de hechizo"};
SCT.LOCALS.OPTION_CHECK104 = { name = "Nombre de Hechizo", tooltipText = "Muestra el nombre del hechizo o habilidad"};
SCT.LOCALS.OPTION_CHECK105 = { name = "Resistencias", tooltipText = "Muestra tu da\195\177o resistido"};
SCT.LOCALS.OPTION_CHECK106 = { name = "Nombre del Objetivo", tooltipText = "Muestra el nombre del objetivo"};
SCT.LOCALS.OPTION_CHECK107 = { name = "Desactivar el Da\195\177o de WoW", tooltipText = "Determina si se muestra el da\195\177o de objetivo integrado en WoW.\n\nNOTA: Esto es lo mismo que si activases las casillas en Opciones Avanzadas en las Opciones de Interfaz. Tienes m\195\161s control ah\195\173."};
SCT.LOCALS.OPTION_CHECK108 = { name = "Solo Objetivo", tooltipText = "Muestra \195\186nicamente el da\195\177o hecho por tu objetivo actual. Los efectos de \195\161rea no son mostrados, a no ser que haya multiples objetivos con el mismo nombre."};
SCT.LOCALS.OPTION_CHECK109 = { name = "Show at Nameplates", tooltipText = "Enables or Disables attempting to show your damage over the nameplate of the mob you damage.\n\nEnemy nameplates must be on, you must be able to see the nameplate, and it will not work 100% of the time (AOE with same named mobs, etc...). If it does not work, damage appears in the normal configured position.\n\nDisabling can require a reloadUI to take effect.\n\n"};
SCT.LOCALS.OPTION_CHECK110 = { name = "Usar Animaci\195\179n de SCT", tooltipText = "Muestra la animaci\195\179n de SCT en vez del texto con estilo de mensaje"};
SCT.LOCALS.OPTION_CHECK111 = { name = "Cr\195\173tico Pegajoso", tooltipText = "Determina si se quedan pegados los golpes cr\195\173ticos. Si se desactiva los mensajes de cr\195\173ticos se mostrar\195\161n como +1236+, etc.. "};
SCT.LOCALS.OPTION_CHECK112 = { name = "Color de Hechizo", tooltipText = "Muestra el da\195\177o de hechizo en color dependiendo de la clase del hechizo (los colores no son configurables)"};
SCT.LOCALS.OPTION_CHECK113 = { name = "Texto de Da\195\177o hacia Abajo", tooltipText = "El texto se desplaza hacia abajo"};
SCT.LOCALS.OPTION_CHECK114 = { name = "Shorten Spell Names", tooltipText = "Enables or Disables shortening spell/skill names (uses SCT settings)"};
SCT.LOCALS.OPTION_CHECK115 = { name = "Enable SCTD Custom Events", tooltipText = "Enables or Disables custom events for SCTD only"};

--Slider options values
SCT.LOCALS.OPTION_SLIDER101 = { name="Posici\195\179n Horizontal del Texto", minText="-600", maxText="600", tooltipText = "Controla la posici\195\179n del centro del texto"};
SCT.LOCALS.OPTION_SLIDER102 = { name="Posici\195\179n Vertical del Texto", minText="-400", maxText="400", tooltipText = "Controla la posici\195\179n del centro del texto"};
SCT.LOCALS.OPTION_SLIDER103 = { name="Velocidad de Desvanecimiento", minText="Faster", maxText="Slower", tooltipText = "Controla la velocidad a la que el texto se desvanece"};
SCT.LOCALS.OPTION_SLIDER104 = { name="Tama\195\177o de Fuente", minText="Peque\195\177o", maxText="Grande", tooltipText = "Controla el tama\195\177o del texto"};
SCT.LOCALS.OPTION_SLIDER105 = { name="Opacidad", minText="0%", maxText="100%", tooltipText = "Controla la opacidad del texto"};
SCT.LOCALS.OPTION_SLIDER106 = { name="Separaci\195\179n de HUD", minText="0", maxText="200", tooltipText = "Controla la distancia desde el centro para las animaciones de HUD. \195\154til cuando quieres mantener todo centrado pero ajustado a una distancia del centro"};

--Misc option values
SCT.LOCALS.OPTION_MISC101 = {name="SCTD Options "..SCTD.Version};
--SCT.LOCALS.OPTION_MISC102 = {name="Cerrar", tooltipText = "Guarda tus ajustes actuales y cierra las opciones"};
SCT.LOCALS.OPTION_MISC103 = {name="SCTD", tooltipText = "Abre el men\195\186 de opciones de SCT - Damage"};
SCT.LOCALS.OPTION_MISC104 = {name="Eventos de Da\195\177o", tooltipText = ""};
SCT.LOCALS.OPTION_MISC105 = {name="Visualizaci\195\179n", tooltipText = ""};
SCT.LOCALS.OPTION_MISC106 = {name="Opciones de Marco", tooltipText = ""};

--Animation Types
SCT.LOCALS.OPTION_SELECTION101 = { name="Fuente de Da\195\177o", tooltipText = "Qu\195\169 fuente usar para los mensajes", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION102 = { name="Borde de la Fuente de Da\195\177o", tooltipText = "Qu\195\169 borde de fuente usar para los mensajes", table = {[1] = "Ninguno",[2] = "Fino",[3] = "Grueso"}};
SCT.LOCALS.OPTION_SELECTION103 = { name="Tipo de Animaci\195\179n de Da\195\177o", tooltipText = "Qu\195\169 tipo de animaci\195\179n usar", table = {[1] = "Vertical (Normal)",[2] = "Arco Iris",[3] = "Horizontal",[4] = "En \195\161ngulo hacia abajo",[5] = "En \195\161ngulo hacia arriba",[6] = "Rociador",[7] = "Curvado en HUD",[8] = "En \195\161ngulo en HUD"}};
SCT.LOCALS.OPTION_SELECTION104 = { name="Estilo de Da\195\177o Lateral", tooltipText = "Como se debe mostrar el desplazamiento lateral de texto", table = {[1] = "Alternando",[2] = "Da\195\177o Izquierda",[3] = "Da\195\177o Derecha", [4] = "Todo a la Izquierda", [5] = "Todo a la Derecha"}};
SCT.LOCALS.OPTION_SELECTION105 = { name="Alineamiento", tooltipText = "C\195\179mo se alinea el texto. Es m\195\161s \195\186til para animaciones verticales o de HUD. El alineamiento de HUD har\195\161 que la parte izquierda se alinee a la derecha y la parte derecha se alinee a la izquierda", table = {[1] = "Izquierda",[2] = "Centro",[3] = "Derecha", [4] = "Centrado en HUD"}};
