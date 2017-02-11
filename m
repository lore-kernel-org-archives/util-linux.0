Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 3/3] hwclock: use gnulib's parse_datetime2 function
To: Assaf Gordon <assafgordon@gmail.com>
References: <bbd64daa-5431-8c7d-580b-3382a33edccd@gmx.com>
 <621b8782-5b62-d07c-c81f-3cfcfbeef8ae@gmx.com>
 <20170210213759.GD24787@gmail.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <b631a678-3c26-3c48-c4f1-a7e652403ff7@gmx.com>
Date: Sat, 11 Feb 2017 11:49:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170210213759.GD24787@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 02/10/2017 04:38 PM, Assaf Gordon wrote:
> Hello William,
> 
> two minor suggestions:
> 
> On Fri, Feb 10, 2017 at 04:08:20PM -0500, J William Piggott wrote:
> 
>> +    if (parse_datetime2 (&when, ctl.date_opt, NULL, ctl.debug))
> 
> 1.  The 'flags' parameter in parse_datetime2 should be considered as a
> bit-field, not a boolean.
>

Hello Assaf,

Thank you, yes I am aware of this. However, I expected push back against
adding gnulib and I didn't want to muddy the discussion waters with this
nuance. So for this simple version it has the effect of turning on
parse_datetime debugging only for odd levels. -D it's on, -DD off, -DDD on ...

*IF* parse_datetime gets accepted, I will address this.
 
> BTW, Turning on the debug flag for parse_datetime2 will emit the
> parsing steps to STDERR, which will look like so:
> https://lists.gnu.org/archive/html/bug-gnulib/2016-08/msg00019.html
> 
> (might be good for util-linux, or might be an overkill).

I think it is useful, but should be at a debug level > 1. Again, *if*
parse_datetime is accepted (which I am not optimistic about after
reading Sami's comments) I will address debugging. I wanted it to be on
at level 1 for this initial introduction so reviewers could observe it
in action. Which is why I offered the suggested testing command in the
cover letter 0/3.

> 
> 2.  The latest version of 'parse_datetime2' function takes 6
> parameters, not just 4. The extra 2 are timezone specific values.
> Added here:
> http://git.savannah.gnu.org/cgit/gnulib.git/commit/lib?id=4e6e16b3f43ce

This I wasn't aware of. Paul added it 2 days after I started this
development branch.

Thank you for the review assaf
> 
> 
> 
> regards,
> - assaf
> 
> 
> -- 
> To
> unsubscribe from
> this list:
> send the
> line
> "unsubscribe
> util-linux" in
> 
> the body
> of a
> message to
> majordomo@vger.kernel.org
> 
> More
> majordomo
> info at 
> http://vger.kernel.org/majordomo-info.html
> 
> 
