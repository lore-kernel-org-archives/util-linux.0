Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <201401091156.16841.vapier@gentoo.org>
References: <1389051548-1268-1-git-send-email-kerolasa@iki.fi>
	<201401081544.37516.vapier@gentoo.org>
	<1389220086-7475-1-git-send-email-kerolasa@iki.fi>
	<201401091156.16841.vapier@gentoo.org>
Date: Fri, 10 Jan 2014 14:29:28 +0000
Message-ID: <CAG27Bk3Ts91ViyXCTbn=KWF4L3jAjcrxRPCbm1vWei8EmyXAWw@mail.gmail.com>
Subject: Re: [PATCH] uuidd: use pkg-config to find systemd-deamon support
From: Sami Kerola <kerolasa@iki.fi>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux <util-linux@vger.kernel.org>, Karel Zak <kzak@redhat.com>,
        =?ISO-8859-1?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 9 January 2014 16:56, Mike Frysinger <vapier@gentoo.org> wrote:
> On Wednesday 08 January 2014 17:28:06 Sami Kerola wrote:
>>  include tests/Makemodule.am
>> +endif        # HAVE_COMMANDS
>
> aren't there some tests for the libs ?

There are some. Taking in consideration Karel's proposal to have
--disable-all-builds that could be combined with
--enable-<per-subdirectory> the tests cannot be skipped in build root
Makefile.am level.

>> +AM_CONDITIONAL(HAVE_COMMANDS, test "x$enable_libraries_only" = xyes)
>
> i'm not sure about this inversion of naming.  why can't it just use
> enable_binaries everywhere ?

Yes, I agree the names could have been better but I did not bother
making the very first hastily wrote patch 100% correct, which is good
since --enable-libraries-only or --disable-commands does not seem to
be what is needed.

>> --- a/login-utils/Makemodule.am
>> +++ b/login-utils/Makemodule.am
>> -install-exec-hook:
>> -if BUILD_SU
>> -if MAKEINSTALL_DO_SETUID
>> -     chmod 4755 $(DESTDIR)$(bindir)/su
>> -endif
>> -endif
>> -if BUILD_VIPW
>> -     cd $(DESTDIR)$(usrsbin_execdir) && ln -sf vipw vigr
>> -endif
>
> why does this need to move ?  this module isn't included when commands are
> disabled ...

automake gave warning the install-exec-hook was if'd out. I think the
sudo suid & vipw will need to use INSTALL_EXEC_HOOKS, and this is
patch has to precede --disable-all-builds change.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
