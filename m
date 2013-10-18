Return-Path: vnwildman@gmail.com
Message-ID: <5260F284.5090601@gmail.com>
Date: Fri, 18 Oct 2013 15:34:12 +0700
From: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux <util-linux@vger.kernel.org>
Subject: Re: gettext error
References: <525F2FC0.70802@gmail.com> <20131018082731.GA15115@x2.net.home>
In-Reply-To: <20131018082731.GA15115@x2.net.home>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 18/10/2013 15:27, Karel Zak wrote:
> On Thu, Oct 17, 2013 at 07:30:56AM +0700, Trần Ngọc Quân wrote:
>> $ nsenter --help
>> display l10n incorrecttly.
>> Fix:
>> Change sys-utils/nsenter.c:189 to:
>> setlocale(LC_ALL, "");
>  Fixed.
Thanks,
You can find more by:
$ grep -r 'setlocale(LC_MESSAGES, "")' ./
$ git grep 'setlocale(LC_MESSAGES, "")' # if use GIT

Please l10n blkid.c
Thanks in advance!

-- 
Trần Ngọc Quân.
