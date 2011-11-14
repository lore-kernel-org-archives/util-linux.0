Return-Path: cosoleto@gmail.com
MIME-Version: 1.0
In-Reply-To: <20111114134259.GB20881@nb.net.home>
References: <1321006331-7633-1-git-send-email-cosoleto@gmail.com>
	<20111114134259.GB20881@nb.net.home>
Date: Mon, 14 Nov 2011 17:03:37 +0100
Message-ID: <CAMFXF53manF_9xPi4Sr=mFx6eg+izR84uhtVUjBAMaXSd_Z1gQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] fdisk: print the welcome message when OSF/1 disklabel
 is detected
From: Francesco Cosoleto <cosoleto@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

2011/11/14 Karel Zak <kzak@redhat.com>:
>> + =A0 =A0 fprintf(stderr, _("Welcome to fdisk (%s).\n\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 "Changes will remain in memory only, until you=
 decide to write them.\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 "Be careful before using the write command.\n"=
), PACKAGE_STRING);
>> +
>
> =A0I have moved this message before gpt_warning() and get_boot(). The
> =A0get_boot() produces very often warnings (for example on disk with no
> =A0PT) and I think that the welcome message should be printed as very
> =A0first message in the interactive mode.

There are some side effects. The third part of the message needs more
visibility, and there is a variable number of newlines. It's possible
split the string up to fix this.

Francesco
