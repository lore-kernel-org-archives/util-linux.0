Return-Path: bensberg@justemail.net
Message-Id: <1314125747.31287.140258132893109@webmail.messagingengine.com>
From: "Benno Schulenberg" <bensberg@justemail.net>
To: kerolasa@gmail.com
Cc: "Karel Zak" <kzak@redhat.com>, "util-linux"
 <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_1314125747312870"
References: <20110815141948.GH2038@nb.net.home><CAG27Bk0LpsVdCJhvOAstC_OpckzfBB05kcZcN_ByF_i_JQU6SQ@mail.gmail.com><1313485424.19019.140258130122469@webmail.messagingengine.com><20110816104652.GA14535@nb.net.home><CAG27Bk3Kvzy+cLCaGh885XLo-MsYY3i5q6_380b_DE8KxXmaNA@mail.gmail.com><1313831405.14363.140258131741205@webmail.messagingengine.com><CAG27Bk0m45JFtP2MNz27tgJ=-f5XZDHUtd1C9O4X0ALO52-BVA@mail.gmail.com><1314045499.25233.140258132498281@webmail.messagingengine.com>
 <CAG27Bk2NS7-tRH4Acp-_WFhAmxELm4cCZ79mwgbXWnDJ7gFAfw@mail.gmail.com>
Subject: Re: man-pages and usage() howto
In-Reply-To: <CAG27Bk2NS7-tRH4Acp-_WFhAmxELm4cCZ79mwgbXWnDJ7gFAfw@mail.gmail.com>
Date: Tue, 23 Aug 2011 20:55:47 +0200
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.

--_----------=_1314125747312870
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Aug 2011 14:55:47 -0400
X-Mailer: MessagingEngine.com Webmail Interface


On Tue, 23 Aug 2011 10:15 +0200, "Sami Kerola" <kerolasa@iki.fi> wrote:
> On Mon, Aug 22, 2011 at 22:38, Benno Schulenberg <bensberg@justemail.net>=
 wrote:
> > (I do not understand your comment about some macros not being
> > visually different from plain .B or .I.)
>=20
> Either my term, groff or pager is/are broken, or I have wooden eyes or
> the different highlights do not stand out, see yourself:
>=20
> http://ut3.org/~kerolasa/groff-highlight.png
>=20
> What I tried to say; Do not get fooled that different macros will look
> different so that you can refer visually in between different text
> elements.

Hmm, maybe you misunderstand what for example the .BI macro does?
It does not mean "bold _plus_ italic" but "alternate bold and italic".  And=
 it
does that perfectly.  See for example the attached example file.

> > Another thing: the man page formatter itself puts a double space after a
> > period when in the man page source the next sentence begins on a new
> > line. =C2=A0So when in the source a new sentence begins somewhere midli=
ne,
> > it should use a double space before its initial letter.
>=20
> Are you sure it does that?

Yes, it does that here, on Ubuntu Lucid 10.10, with man 2.5.7.

> See the screenshot notes section third
> paragraph line two, words `macros. See' has only single space in
> between them.

Yes, but in the source it says "appropriate groff macros. See" on a single
line.  When you put the "See" on a line by itself, you wil see two spaces
appear before it.  See the attached example file.

> Even there would be two spaces I do not agree that groff
> input writer should imitate output. It should be enough that words and
> sentences are white space separated, groff will take care the rest.

Well, being a doublespacer myself, I notice it when some sentences are
single-spaced and others double; it irks.  But never mind.

Regards,

Benno

--=20
http://www.fastmail.fm - A fast, anti-spam email service.


--_----------=_1314125747312870
MIME-Version: 1.0
Content-Disposition: attachment; filename="junk.1"
Content-Id: <27823e43a21d8ba7339a67a44053ab633769411f@messagingengine.com>
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream; name="junk.1"
X-Mailer: MIME::Lite 3.027 (F2.77; A2.06; B3.08; Q3.08)
Date: Tue, 23 Aug 2011 14:55:47 -0400

LlRIIEpVTksgMSAiVG9kYXkiICJFeGFtcGxlIiAiU3BhY2lvdXNuZXNzIgou
U0ggTkFNRQpqdW5rIFwtIGRvIG5vdGhpbmcKLlNIIERFU0NSSVBUSU9OCi5C
IGp1bmsKZG9lcyBub3RoaW5nLgpKdXN0IHNob3cuClRoYXQuCkFmdGVyLgou
UFAKRWFjaCBwZXJpb2QuClBsdXMgbmV3bGluZS4KRm9sbG93IHR3byBzcGFj
ZXMuCi5TSCBGT1JNQVRUSU5HCi5QUAouQlIgXC5CUlwgIGFsdGVybmF0ZVwg
IGJvbGRcICBhbmRcICBub3JtYWxcICBhbmRcICBzb1wgIG9uXCAgYW5kXCAg
c29cICBvbgouUFAKLkJJIFwuQklcICBhbHRlcm5hdGVcICBib2xkXCAgYW5k
XCAgaXRhbGljCi5QUAouSUIgXC5JQlwgIGFsdGVybmF0ZVwgIGl0YWxpY1wg
IGFuZFwgIGJvbGQKLlBQCi5JUiBcLklSXCAgYWx0ZXJuYXRlXCAgaXRhbGlj
XCAgYW5kXCAgbm9ybWFsCi5QUAouUkIgXC5SQlwgIGFsdGVybmF0ZVwgIG5v
cm1hbFwgIGFuZFwgIGJvbGQKLlBQCi5SSSBcLlJJXCAgYWx0ZXJuYXRlXCAg
bm9ybWFsXCAgYW5kXCAgaXRhbGljXCAgYW5kXCAgc29cICBvblwgIGFuZFwg
IHNvXCAgb24K

--_----------=_1314125747312870--
