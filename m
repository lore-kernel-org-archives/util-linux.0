Return-Path: ingenit@zoho.com
Message-ID: <50F01013.2000100@zoho.com>
Date: Fri, 11 Jan 2013 14:13:55 +0100
From: =?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: mtk.manpages@gmail.com, util-linux@vger.kernel.org,
        Neil Horman <nhorman@tuxdriver.com>, Karel Zak <kzak@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] enter: new command (light wrapper around setns)
References: <876234812z.fsf@xmission.com> <CAKgNAkjOw-KPJO5AFRSwtoOb0k7K64pk1O-gRs-GS18ZQCYmaQ@mail.gmail.com> <87fw283rht.fsf@xmission.com>
In-Reply-To: <87fw283rht.fsf@xmission.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 11/01/13 12:10, Eric W. Biederman wrote:
> "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:
> 
>> Hi Eric,
>>
>> On Fri, Jan 11, 2013 at 11:29 AM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>>
>>> Inspired by unshare, enter is a simple wrapper around setns that
>>> allows running a new process in the context of an existing process.
>>
>> The name "enter" seems way too generic (far more so than even
>> "unshare"). How about "nsexec" or "execns" or some such?
> 
> Enter unlike exec is the right concept, and the name is free.

What about enterns ?
