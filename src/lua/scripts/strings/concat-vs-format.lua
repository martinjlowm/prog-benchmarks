function main()
    local sFormat = string.format
    local oClock = os.clock
    local total = 0
    local total2 = 0
    local totalN = 20
    for j = 1, totalN do
        local startTime = oClock()

        local N = 1e6
        local a = 0
        local b

        for i = 1, N do
            a = a + 1
            b = sFormat('%d-', a)
        end

        total = total + (oClock() - startTime)

        startTime = oClock()

        for i = 1, N do
            a = a + 1
            b = tostring(a) .. '-'
        end

        total2 = total2 + (oClock() - startTime)
    end

    print(sFormat('string.format: %.2fs', total / totalN))
    print(sFormat('concatenation: %.2fs', total2 / totalN))

end

main()
