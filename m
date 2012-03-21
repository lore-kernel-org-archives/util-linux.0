Return-Path: ikanobori87@gmail.com
MIME-Version: 1.0
Sender: ikanobori87@gmail.com
In-Reply-To: <20120321184419.GE2040@x2.net.home>
References: <CANXSoSB_JTjcwfCPu6vJLdtLtR5e1M4VHJiDu2NpGo=hp6SMrA@mail.gmail.com>
	<20120321184419.GE2040@x2.net.home>
Date: Wed, 21 Mar 2012 22:47:52 +0100
Message-ID: <CANXSoSCA5j95J2fAjUXPfPj9oue2xWNrK5AmVTQd+KNSi=VvBg@mail.gmail.com>
Subject: Re: hexsyntax.c using strtol on the offset parameter
From: Simon de Vlieger <simon@ikanobori.jp>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

Karel,

thank you for your swift response and fix.

Simon

On 21 March 2012 19:44, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Mar 21, 2012 at 03:53:55PM +0100, Simon de Vlieger wrote:
>> The line I think I have it narrowed down to is line 92 of
>> util-linux/hexsyntax.c where the -s parameter is converted to a long.
>
> =C2=A0Fixed. The code (as well as -n) was stupid. Now it supports all
> =C2=A0possible suffixes (K,M,G,T,P,E,Y,Z) and the number is parsed as
> =C2=A0uintmax_t.
>
>> Sadly the size of a 1 TB disk overflows the size of a long. Can the
>> off_t maybe be changed to use off64_t (if this is relevant) and use
>
> =C2=A0The problem is not off_t, but strtol().
>
> =C2=A0Thanks!
>
> =C2=A0 =C2=A0Karel
>
> --
> =C2=A0Karel Zak =C2=A0<kzak@redhat.com>
> =C2=A0http://karelzak.blogspot.com
