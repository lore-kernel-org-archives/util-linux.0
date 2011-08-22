Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20110822081654.GH699@nb.net.home>
References: <20110815141948.GH2038@nb.net.home>
	<CAG27Bk0LpsVdCJhvOAstC_OpckzfBB05kcZcN_ByF_i_JQU6SQ@mail.gmail.com>
	<1313485424.19019.140258130122469@webmail.messagingengine.com>
	<20110816104652.GA14535@nb.net.home>
	<CAG27Bk3Kvzy+cLCaGh885XLo-MsYY3i5q6_380b_DE8KxXmaNA@mail.gmail.com>
	<1313831405.14363.140258131741205@webmail.messagingengine.com>
	<CAG27Bk0m45JFtP2MNz27tgJ=-f5XZDHUtd1C9O4X0ALO52-BVA@mail.gmail.com>
	<20110822081654.GH699@nb.net.home>
Date: Mon, 22 Aug 2011 20:53:15 +0200
Message-ID: <CAG27Bk1ciBTrBpj6JbfYmNeKeCfgHLtf_obA20D02Tsdws5hmw@mail.gmail.com>
Subject: Re: man-pages and usage() howto
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Benno Schulenberg <bensberg@justemail.net>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 22, 2011 at 10:16, Karel Zak <kzak@redhat.com> wrote:
>> IMHO the following looks quite ok, and not too different to
>> usage().
>>
>> .TP
>> \fB\-n\fR, \fB\-\-no\-argument\fR
>> This option does not use argument.
>> .TP
>> \fB\-o\fR, \fB\-\-optional\fR[=3D<\fIarg\fR>]
>> This option uses optional argument.
>> .TP
>> \fB\-r\fR, \fB\-\-required\fR <\fIarg\fR>
>> This option requires an argument.
>
> =A0I have no strong opinion about it. Benno is probably right that
> =A0italics for the arguments is enough.
>
> =A0We already use option arguments without diamond brackets in our man
> =A0pages, so let's continue with this convention to minimize number of
> =A0changes in the man pages ;-)

The howto-man-page.txt now has arguments underlined without diamond
brackets. Optional argument has square brackets surrounding it.

Is the patch set ready now? Have a look, and in absence of comments
merge might be reasonable thing to do after few days.

https://github.com/kerolasa/lelux-utiliteetit/tree/docs-dir/Documentation

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/
