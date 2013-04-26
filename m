Return-Path: richard@nod.at
Message-ID: <517A1311.5000209@nod.at>
Date: Fri, 26 Apr 2013 07:39:29 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: kzak@redhat.com, util-linux@vger.kernel.org, davidlohr.bueso@hp.com
Subject: Re: [PATCH] nsenter: Allow selecting the uid and gid to be used in
 the entered userns
References: <1366917100-10581-1-git-send-email-richard@nod.at> <871u9yqf5d.fsf@xmission.com>
In-Reply-To: <871u9yqf5d.fsf@xmission.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-ID: <util-linux.vger.kernel.org>

Am 26.04.2013 03:01, schrieb Eric W. Biederman:
> Richard Weinberger <richard@nod.at> writes:
>
>> Using -S (--setuid) and -G (--setgid) one can select
>> the uid/gid which will be used in the entered user namespace.
>
> There is definitely utility here.  I don't have a strong preference but
> I am inclined to suggest that you remove the set_uid and set_gid
> variables, and unconditionally call setuid and setgid when entering
> a user namespace.

I thought about that too. But this would introduce a behavior change.
Karel, are you fine with such a change?

Thanks,
//richard
