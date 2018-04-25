function main()
    local function localFunc(a)
        return a
    end

    local inlineFunc

    inlineFunc = function(a)
    end

    local sFormat = string.format
    local oClock = os.clock
    local total, totalN = 0, 20
    for j = 1, totalN do
        local startTime = oClock()

        local N = 1e8
        local a = 0
        local b

        for i = 1, N do
            a = a + 1
            b = sFormat('%d', a)
        end

        total = total + (oClock() - startTime)
    end

    print(sFormat('local incrementor, local limit: %.2fs',
                  total / totalN))

end

main()
