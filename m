Return-Path: ingenit@zoho.com
Message-ID: <5106E28F.7040901@zoho.com>
Date: Mon, 28 Jan 2013 21:41:51 +0100
From: =?UTF-8?B?w4FuZ2VsIEdvbnrDoWxleg==?= <ingenit@zoho.com>
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?=
 <zbyszek@in.waw.pl>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 2/5] nsenter: add --all meaning all namespaces and cwd
 and root
References: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl> <1358750287-17732-3-git-send-email-zbyszek@in.waw.pl> <20130125150210.GL27413@x2.net.home> <20130125163924.GT4278@in.waw.pl> <87pq0tjgx9.fsf@xmission.com> <51054B8E.2000205@zoho.com> <874ni22frn.fsf@xmission.com>
In-Reply-To: <874ni22frn.fsf@xmission.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 28/01/13 03:38, Eric W. Biederman wrote:
> Ángel González <ingenit@zoho.com> writes:
>> Except that when you are distributing such script (eg. an init-like
>> script), your shell script will need to add code detecting which
>> namespaces the kernel supports (and adding appropiate flags to nsenter)
>> and checking if your nsenter version supports them or not.
> 
> Then what you want is --ignore-namespaces-if-not-supported-in-kernel.
> That is a somewhat different problem than --all.

No, I also want it to do
--include-namespaces-i-did-not-know-when-writing-this-shell-script :)



>> It's better to have --all to enter all namespaces that nsenter supports.
>> If you want to, it could print a warning when using --all and nsenter
>> knows about more namespaces than the kernel or if it detects that the
>> kernel knows about more namespaces than itself.
>> But having a --all to enter “as namespaces as possible” would be the
>> right thing IMHO.
> 
> The argument for --all and this is an argument that only applies to
> nsenter and not unshare is that usually things are more likely to do
> what you expect if you share more namespaces with them.
> 
> The counter argument is that sharing fewer namespaces than expected
> can easily invalidate your testing and introduce subtle bugs.
> 
> "nsenter -t $pid --all" is what I want most days, but I can't
> convince myself that "nsenter -t $pid -muinpUrw" is worse (just a few
> more characters) and it has the advantage that what has worked before
> should work again.
> 
> Right now --all looks like a subtle trap waiting for users.  Even
> --ignore-namespaces-if-not-supported-in-kernel looks like that to
> a degree.
> 
> With nsenter if we don't ignore failures when something we need is
> missing the failure is up there and in your face.  If we do ignore
> failures we can easily run into cases where commands that we run
> continue to work but on the wrong namespaces, causing all kinds of
> things to fail.
> 
> Think about using: "nsneter -t $pid -p /bin/kill -KILL -1" to ask a
> container to shutdown.  If we were to ignore the fact you can't enter
> the pid namespace than the command would kill everything and the box
> would go down.
> 
> That seems very scary.   So I don't like removing namespaces silently.

It could show a "Warning: Your kernel doesn't support pid namespaces"
in stderr.

No texactly ideal in your case, but slightly better.
Another option is to add --all-available, making a hard error not having
the namespaces specified by the explicit options but
--all-available to ignore missing ones.

> Having an --all that could mean everything nsenter supports this week
> is better but you start getting shell scripts that work fine on new
> distros but fail in horrible ways on old distro's with old versions of
> nsenter.  That certainly is better but still a bit of a scary prospect.
> 
> Eric

The namespaces-of-the-week could be a configure option for people
running on old kernels, but I don't see much way for improvement.
