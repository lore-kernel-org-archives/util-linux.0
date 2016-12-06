Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751829AbcLFObo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Dec 2016 09:31:44 -0500
Date: Tue, 6 Dec 2016 15:31:42 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: fuzzing anybody
Message-ID: <20161206143142.3sah5eg7he6whqbz@ws.net.home>
References: <201612061326.09245.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201612061326.09245.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 06, 2016 at 01:26:09PM +0100, Ruediger Meier wrote:
> google is offereing "Fuzz testing" for famous OSS projects
>   https://github.com/google/oss-fuzz
> 
> I've thought this might be a nice idea for util-linux and already 
> registered
>   https://github.com/google/oss-fuzz/pull/120
> 
> Stupidly I've missed the point that I would also need to write some code 
> which intelligently feeds our UL programs with the generated random 
> data to find bugs. I thought that this is what google would do for us 
> but they only give us the their infrastructure for running the actual 
> tests. ;)
> 
> So if anybody is interested in this fuzzing topic ... maybe someone has 
> a good idea, say how to feed libsmartcol or libblkid with random data.

Good idea for libblkid (I have already seen report about minix if I
good remember). Not sure about libsmartcol where it's application who
fill data to the table.

> A good and even interesting point to start is this "libFuzzer Tutorial":
> https://github.com/google/fuzzer-test-suite/blob/master/tutorial/libFuzzerTutorial.md
> 
> Also interesting to see how other projects are doing it already in 
> google's oss-fuzz.
> 
> for example curl: 
> https://github.com/google/oss-fuzz/blob/master/projects/curl/curl_fuzzer.cc
> 
> or openssl which has a fuzz/ sub-directory in their original project.
> https://github.com/openssl/openssl/tree/master/fuzz

Go ahead, tests/fuzz/ is no problem :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
