#
# reliably emits the nested hash/array structure intended to
# be passed as the $vars reference in proc.pl.   
#
# its output is equivalent to the file input/data.yaml
#
#
use strict;
use YAML;

my $body4 = <<__;
<p><img src="http://media.tumblr.com/tumblr_ksai958LQr1qa64s0.jpg"/></p>
<p>phaselus ille quem videtis hospites</p>
<p>ait fuisse navium celerrimus</p>
<p>neque ullus natantis impetum trabis</p>
<p>nequisse praeterire sive palmulis</p>
<p>opus foret volare sive linteo</p>
<p>et hoc negat minacis Hadriatici</p>
<p>negare litus insulasve Cycladas</p>
<p>Rhodumque nobilem horridamque Thraciam</p>
<p>Propontida trucemve Ponticum sinum</p>
<p>ubi iste post phaselus antea fuit</p>
<p>comata silva nam Cytorioin iugo</p>
<p>loquente saepe sibilum edidit coma</p>
<p>Amastri Pontica et Cytore buxifer</p>
<p>tibi haec fuisse et esse cognitissima</p>
<p>ait phaselus ultima ex origine</p>
<p>tuo stetisse dicit in cacumine</p>
<p>tuo imbuisse palmulas in aequore</p>
<p>et inde tot per impotentia freta</p>
<p>erum tulisse laeva sive dextera</p>
<p>vocaret aura sive utrumque Iuppiter</p>
<p>simul secundus incidisset in pedem</p>
<p>neque ulla vota litoralibus deis</p>
<p>sibi esse facta cum veniret a mari</p>
<p>novissimo hunc ad usque limpidum lacum</p>
<p>sed haec prius fuere nunc recondita</p>
<p>senet quiete seque dedicat tibi</p>
<p>gemelle Castor et gemelle Castoris</p>
__

my $body2=<<__;
<p>Passer,<sup></sup>deliciae meae puellae,</p>
<p>quicum ludere, quem in sinu tenere,</p>
<p>cui primum digitum dare appetenti</p>
<p>et acris solet incitare morsus,</p>
<p>cum desiderio meo nitenti</p>
<p>carum nescioquid lubet iocari,</p>
<p>ut solaciolum sui doloris,</p>
<p>credo, ut tum gravis acquiescat ardor;</p>
<p>tecum<sup></sup>ludere sicut ipsa possem</p>
<p>et tristis animi levare curas!</p>
__

my $body1=<<__;
<p>cui dono lepidum novum libellum</p>
<p>arida modo pumice expolitum</p>
<p>Corneli tibi namque tu solebas</p>
<p>meas esse aliquid putare nugas</p>
<p>iam tum cum ausus es unus Italorum</p>
<p>omne aevum tribus explicare cartis</p>
<p>doctis Iuppiter et laboriosis</p>
<p>quare habe tibi quidquid hoc libelli</p>
<p>qualecumque quod o<sup></sup>patrona virgo</p>
<p>plus uno maneat perenne saeclo</p>
__

my %data = ( 
	main => { 
		Title => 'Theory of Everything',
		RSS => 'http://theoryofeverything.tumblr.com/rss',
		Favicon => 'http://18.media.tumblr.com/avatar_ed2edc19affc_16.png',
		Description => 'All things to all people.',
		MetaDescription => 'All things to all people.',
		CustomCSS => '/* custom CSS goes here */'
	},
	posts => [
		{
			Title => 'Quattuor',
			Text => 1, 
			Body => $body4,
			Permalink => 'http://theoryofeverything.tumblr.com/post/227148220/quattuor',
			DayOfMonth => 29,
			DayOfMonthSuffix => 'th', 
			Month => 'October',
			Year => 2009
		},{
			Title => 'Duo',
			Text => 1, 
			Body => $body2,
			Permalink => 'http://theoryofeverything.tumblr.com/post/227142357/duo',
			DayOfMonth => 29,
			DayOfMonthSuffix => 'th', 
			Month => 'October',
			Year => 2009
		},{
			Title => 'Unus',
			Text => 1,
			Body => $body1,
			Permalink => 'http://theoryofeverything.tumblr.com/post/227133157/unus', 
			DayOfMonth => 29,
			DayOfMonthSuffix => 'th', 
			Month => 'October',
			Year => 2009
		}
	],
);

print Dump \%data
