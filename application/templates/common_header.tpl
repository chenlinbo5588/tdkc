<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>{$TITLE}</title>
    <meta name="keywords" content="{$KEYWORDS}">
    <meta name="description" content="{$DESCRIPTION}">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    {foreach from=$cssFiles item=cssItem}<link href="css/{$cssItem}.css" rel='stylesheet' type='text/css'>
    {/foreach}
</head>
<body>