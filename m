Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:62891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751798AbcLFM15 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Dec 2016 07:27:57 -0500
Received: from zappa.ga.local ([87.128.112.108]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzbXq-1ciOki0l98-014nBm for
 <util-linux@vger.kernel.org>; Tue, 06 Dec 2016 13:26:10 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: fuzzing anybody
Date: Tue, 6 Dec 2016 13:26:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201612061326.09245.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

google is offereing "Fuzz testing" for famous OSS projects
  https://github.com/google/oss-fuzz

I've thought this might be a nice idea for util-linux and already 
registered
  https://github.com/google/oss-fuzz/pull/120

Stupidly I've missed the point that I would also need to write some code 
which intelligently feeds our UL programs with the generated random 
data to find bugs. I thought that this is what google would do for us 
but they only give us the their infrastructure for running the actual 
tests. ;)

So if anybody is interested in this fuzzing topic ... maybe someone has 
a good idea, say how to feed libsmartcol or libblkid with random data.

A good and even interesting point to start is this "libFuzzer Tutorial":
https://github.com/google/fuzzer-test-suite/blob/master/tutorial/libFuzzerTutorial.md

Also interesting to see how other projects are doing it already in 
google's oss-fuzz.

for example curl: 
https://github.com/google/oss-fuzz/blob/master/projects/curl/curl_fuzzer.cc

or openssl which has a fuzz/ sub-directory in their original project.
https://github.com/openssl/openssl/tree/master/fuzz

cu,
Rudi
