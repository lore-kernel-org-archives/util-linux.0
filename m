Return-Path: casantos@datacom.com.br
Date: Wed, 6 Jun 2018 09:02:27 -0300 (BRT)
From: Carlos Santos <casantos@datacom.com.br>
To: =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Message-ID: <781894140.1411342.1528286547497.JavaMail.zimbra@datacom.com.br>
In-Reply-To: <87lgby1vvn.fsf@suse.com>
References: <20180601113807.ghf6dtcd5xa6qptu@ws.net.home> <87lgby1vvn.fsf@suse.com>
Subject: Re: hardlink util -- files de-duplication
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

> From: "Aur=C3=A9lien Aptel" <aaptel@suse.com>
> To: "Karel Zak" <kzak@redhat.com>, "util-linux" <util-linux@vger.kernel.o=
rg>
> Sent: Friday, June 1, 2018 10:25:48 AM
> Subject: Re: hardlink util -- files de-duplication

> Karel Zak <kzak@redhat.com> writes:
>> Comments & objections?
>=20
> Not objecting but I feel like I should mention there are multiple
> well-established alternatives:
>=20
> https://github.com/tobiasschulz/fdupes
> http://freedup.org/
> https://rdfind.pauldreik.se/
> https://github.com/markfasheh/duperemove

Compared to hardlink, fdupes has a richer feature set (e.g. dedupsoft
links). FreeDup has its own life and does not seem to be adoptable.
Dupremove is a complex software which requires glib2 and sqlite3.

--=20
Carlos Santos (Casantos) - DATACOM, P&D
=E2=80=9CMarched towards the enemy, spear upright, armed with the certainty
that only the ignorant can have.=E2=80=9D =E2=80=94 Epitaph of a volunteer
