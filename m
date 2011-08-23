Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <1314125747.31287.140258132893109@webmail.messagingengine.com>
References: <20110815141948.GH2038@nb.net.home>
	<CAG27Bk0LpsVdCJhvOAstC_OpckzfBB05kcZcN_ByF_i_JQU6SQ@mail.gmail.com>
	<1313485424.19019.140258130122469@webmail.messagingengine.com>
	<20110816104652.GA14535@nb.net.home>
	<CAG27Bk3Kvzy+cLCaGh885XLo-MsYY3i5q6_380b_DE8KxXmaNA@mail.gmail.com>
	<1313831405.14363.140258131741205@webmail.messagingengine.com>
	<CAG27Bk0m45JFtP2MNz27tgJ=-f5XZDHUtd1C9O4X0ALO52-BVA@mail.gmail.com>
	<1314045499.25233.140258132498281@webmail.messagingengine.com>
	<CAG27Bk2NS7-tRH4Acp-_WFhAmxELm4cCZ79mwgbXWnDJ7gFAfw@mail.gmail.com>
	<1314125747.31287.140258132893109@webmail.messagingengine.com>
Date: Tue, 23 Aug 2011 21:34:54 +0200
Message-ID: <CAG27Bk0N8qjr-BYsmdRiNP4H3-2aBAqxOKSqO5V+bbgtSby-uQ@mail.gmail.com>
Subject: Re: man-pages and usage() howto
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 23, 2011 at 20:55, Benno Schulenberg <bensberg@justemail.net> w=
rote:
> On Tue, 23 Aug 2011 10:15 +0200, "Sami Kerola" <kerolasa@iki.fi> wrote:
>> On Mon, Aug 22, 2011 at 22:38, Benno Schulenberg <bensberg@justemail.net=
> wrote:
>> > (I do not understand your comment about some macros not being
>> > visually different from plain .B or .I.)
>>
>> Either my term, groff or pager is/are broken, or I have wooden eyes or
>> the different highlights do not stand out, see yourself:
>>
>> http://ut3.org/~kerolasa/groff-highlight.png
>>
>> What I tried to say; Do not get fooled that different macros will look
>> different so that you can refer visually in between different text
>> elements.
>
> Hmm, maybe you misunderstand what for example the .BI macro does?
> It does not mean "bold _plus_ italic" but "alternate bold and italic". =
=A0And it
> does that perfectly. =A0See for example the attached example file.

Indeed I have. Thank you clarifying that, and as obvious the strange
(wrong) instruction in howto-man-page.txt is gone.

>> > Another thing: the man page formatter itself puts a double space after=
 a
>> > period when in the man page source the next sentence begins on a new
>> > line. =A0So when in the source a new sentence begins somewhere midline=
,
>> > it should use a double space before its initial letter.
>>
>> Are you sure it does that?
>
> Yes, it does that here, on Ubuntu Lucid 10.10, with man 2.5.7.
>
>> See the screenshot notes section third
>> paragraph line two, words `macros. See' has only single space in
>> between them.
>
> Yes, but in the source it says "appropriate groff macros. See" on a singl=
e
> line. =A0When you put the "See" on a line by itself, you wil see two spac=
es
> appear before it. =A0See the attached example file.

I'm quite near to say groff is a stupid program. Well, it seems that
the instructions should indeed tell to use french spacing e.g. two
spaces after a dot. After all it would be even more ridiculous to ask
people to use dot only at middle of line so that groff will never add
two spaces.

>> Even there would be two spaces I do not agree that groff
>> input writer should imitate output. It should be enough that words and
>> sentences are white space separated, groff will take care the rest.
>
> Well, being a doublespacer myself, I notice it when some sentences are
> single-spaced and others double; it irks. =A0But never mind.

Quite the opposite, I did not know I where talking. Thanks again
pointing out how wrong I where.

p.s. The usage() option thing is fixed as well.

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/
