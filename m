Return-Path: elseifthen@gmx.com
Subject: Re: [V3 PULL] hwclock: remove date(1)
To: Karel Zak <kzak@redhat.com>
References: <a1415b5d-4046-3b34-5836-40ce1a835a41@gmx.com>
 <20170314131705.vag4vmrlemrcfsj4@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <7335247a-fea0-80aa-c8b2-d86b6847b019@gmx.com>
Date: Wed, 22 Mar 2017 20:43:05 -0400
MIME-Version: 1.0
In-Reply-To: <20170314131705.vag4vmrlemrcfsj4@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

ping

On 03/14/2017 09:17 AM, Karel Zak wrote:
> On Sat, Mar 04, 2017 at 04:56:12PM -0500, J William Piggott wrote:
>>  Here's the latest branch for adding parse-date.
> 
> Reviewed, it seems ready do merge from my point of view. Objections?
> 
> TODO (after merge):
>   - add lib/test_parse_date.c
>   - add tests/ts/misc/parse_date regression test
>   - replace parse_timestamp() with new parse_date() 
> 
> 
>     Karel
> 
