? my $p = $_[0];
<html>
<head><title>Programming languages</title></head>
<body>
<h1><?= $p->{page_title} ?></h1>
<br />
<ul>
? for my $language (@{ $p->{languages} }) {
<li><?= $language->{language} ?></li>
? }
</ul>
</body>
</html>
