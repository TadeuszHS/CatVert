--!strict

const lest = require("../Lest")
const describe, it, expect = lest.describe, lest.it, lest.expect

const Structure = require("../CatVert/data/Structure")
const Conversion = require("../CatVert/data/Conversion")
const Element = require("../CatVert/data/element/Element")
const Property = require("../CatVert/data/property/Property")

type ElementClassNames = Structure.ElementClassNames
type Element = Element.Element
type Property = Property.Property

describe("Conversion", function()
    for class_name, element in Conversion.Element :: { [ElementClassNames]: Element } do
        describe(`Element: '{class_name}'`, function()
            local inst: Instance

            it("has a valid 'roblox_class'", function()
                expect(function()
                    inst = Instance.new(element.roblox_class)
                end).toNotThrow()
            end)

            for catweb_index, property in element.properties do
                if property.class == "Property" then
                    describe(`Property: '{catweb_index}'`, function()
                        local value: unknown

                        it("has a valid 'roblox_index'", function()
                            expect(function()
                                value = (inst :: any)[(property :: Property).roblox_index]
                            end).toNotThrow()
                        end)

                        it("has a valid 'value_type'", function()
                            expect(
                                if typeof(value) == "EnumItem" then 
                                    tostring(value.EnumType)
                                else
                                    typeof(value)
                            ).toBe((property :: Property).value_type)
                        end)
                    end)
                end
            end
        end)
    end
end)

return nil
