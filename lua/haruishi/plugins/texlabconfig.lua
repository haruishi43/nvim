local setup, texlab = pcall(require, "texlabconfig")
if not setup then
	return
end

texlab.setup()
