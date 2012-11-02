Return-Path: mschmidt@redhat.com
Message-ID: <5093C317.3060406@redhat.com>
Date: Fri, 02 Nov 2012 13:56:55 +0100
From: Michal Schmidt <mschmidt@redhat.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: fix autodetection for TERM
References: <1351549981-32412-1-git-send-email-mschmidt@redhat.com> <20121102114038.GC30319@x2.net.home>
In-Reply-To: <20121102114038.GC30319@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>

Dne 2.11.2012 12:40, Karel Zak napsal(a):
> On Mon, Oct 29, 2012 at 11:33:01PM +0100, Michal Schmidt wrote:
>> open_tty() autodetects whether to set TERM to "linux" or "vt102", but it
>> can apply the result only if op->term is still NULL.
>
>   Oh, nice. Do you have any reference to bugzilla?

I discovered it while looking into this systemd bug:
https://bugzilla.redhat.com/show_bug.cgi?id=870622#c1

Michal
