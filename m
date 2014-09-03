Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Adam Sampson <ats@offog.org>
Subject: Re: [ANNOUNCE] util-linux v2.25.1
Date: Thu, 4 Sep 2014 00:19:11 +0200
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20140903105427.GH21325@x2.net.home> <20140903155554.GS885@cartman.at.offog.org>
In-Reply-To: <20140903155554.GS885@cartman.at.offog.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201409040019.12248.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 03 September 2014, Adam Sampson wrote:
> On Wed, Sep 03, 2014 at 12:54:27PM +0200, Karel Zak wrote:
> >    - make ipcs limit calculations work when numbers are large
>
> That change isn't right -- it reverses the sense of the test, making
> the testcase fail on 3.16 again. Patch attached.

Your patch seems to be correct except that it should be "<=" instead 
of "<":
  if [ $(bc <<<"2^64 / $PAGE_SIZE <= $SHMALL") -eq 1 ]; then
to have the same (correct) behavior like before 3a9ec12d.

The mistake in 3a9ec12d happened probably because Sami tried to 
avoid "greater than" relations. but for my brain this line would be 
still more easy to read:
  if [ $(bc <<<"$SHMALL >= 2^64 / $PAGE_SIZE") -eq 1 ]; then
Maybe that's why me and others have not noticed the mistake when 
reviewing that patch.

cu,
Rudi
