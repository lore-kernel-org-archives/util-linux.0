Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 1/2] cal: fix week calculations for 1752
To: Karel Zak <kzak@redhat.com>
References: <a6d50a7c-6938-6f29-a983-039c5a422a7f@gmx.com>
 <20180122132841.6axu2ji3uzi2q523@ws.net.home>
From: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Message-ID: <f4d7f386-220d-5264-78cc-77ebdc3706ca@gmx.com>
Date: Mon, 22 Jan 2018 15:58:25 -0500
MIME-Version: 1.0
In-Reply-To: <20180122132841.6axu2ji3uzi2q523@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 01/22/2018 08:28 AM, Karel Zak wrote:
> On Mon, Jan 22, 2018 at 07:01:23AM -0500, J William Piggott wrote:
>>  misc-utils/cal.c | 3 +++
>>  1 file changed, 3 insertions(+)
> 
> The both patches applied, and "--week=40 1752" added to tests.

I didn't look at the test, but note that the week 40 bug only affected
the proleptic Gregorian output:
cal --week=40 --iso 1752

The week 39 bug only affected the default (1752) output:
cal --week=39 1752

You might want to hold off on updating the tests until my queue of bug
fixes is emptied ;) 



> 
>     Karel
> 
