module.exports = function (eleventyConfig) {
  const pathPrefix = process.env.GITHUB_PAGES ? "/site-eaglesecurity" : "";
  eleventyConfig.addGlobalData("pathPrefix", pathPrefix);

  eleventyConfig.addPassthroughCopy("assets");
  eleventyConfig.addPassthroughCopy("content/**/*.png");
  eleventyConfig.addPassthroughCopy("content/**/*.jpg");
  eleventyConfig.addPassthroughCopy("content/**/*.webp");
  // Copy logo from project root input/ if present (e.g. input/logo.png -> assets/img/logo.png)
  eleventyConfig.addPassthroughCopy({ "../input/logo.png": "assets/img/logo.png" });
  eleventyConfig.addPassthroughCopy({ "../input/logo.jpg": "assets/img/logo.jpg" });

  return {
    dir: {
      input: "content",
      includes: "../_includes",
      data: "../_data",
      output: "_site",
    },
    pathPrefix: pathPrefix ? pathPrefix + "/" : "",
  };
};
