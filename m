Return-Path: teg@jklm.no
MIME-Version: 1.0
In-Reply-To: <20120403140140.GK1084@x2.net.home>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
 <1333039528-24784-14-git-send-email-petr.uzel@suse.cz> <20120403140140.GK1084@x2.net.home>
From: Tom Gundersen <teg@jklm.no>
Date: Tue, 3 Apr 2012 16:47:00 +0200
Message-ID: <CAG-2HqUudB4k4xGq7b7iwYGRCa-7eam0TmQGd9B35MhC3sBfKg@mail.gmail.com>
Subject: Re: [PATCH 13/20] uuidd: add systemd unit files
To: Karel Zak <kzak@redhat.com>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 3, 2012 at 4:01 PM, Karel Zak <kzak@redhat.com> wrote:
> On Thu, Mar 29, 2012 at 06:45:21PM +0200, Petr Uzel wrote:
>> +AC_ARG_WITH([systemdsystemunitdir],
>> + =C2=A0AS_HELP_STRING([--with-systemdsystemunitdir=3DDIR], [directory f=
or systemd service files]),
>
> =C2=A0systemdsystemunitdir ???

This is the variable name most other projcts use for this purpos. The
reason being that it is suggested here:
<http://0pointer.de/public/systemd-man/daemon.html>.

-t
