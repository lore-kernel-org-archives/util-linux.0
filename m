Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f173.google.com ([209.85.192.173]:50521 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaCSTCY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 19 Mar 2014 15:02:24 -0400
Received: by mail-pd0-f173.google.com with SMTP id z10so9074309pdj.32
        for <util-linux@vger.kernel.org>; Wed, 19 Mar 2014 12:02:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1395232676.8853.96331789.08D073EF@webmail.messagingengine.com>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
	<1394397023-7050-5-git-send-email-kerolasa@iki.fi>
	<1395232676.8853.96331789.08D073EF@webmail.messagingengine.com>
Date: Wed, 19 Mar 2014 19:02:23 +0000
Message-ID: <CAG27Bk1v8RGc++K23-NhPNBmv_VG+XUANT-108qF7FT7kkmFsg@mail.gmail.com>
Subject: Re: [PATCH 05/10] kill: make usage() not to return
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 19 March 2014 12:37, Benno Schulenberg <bensberg@justemail.net> wrote:
> On Sun, Mar 9, 2014, at 21:30, Sami Kerola wrote:
>> And change the function argument to be output stream.  Earlier the --help
>> made kill to exit with none zero value, that now is corrected.
>
> Textual amendments:
>
> s/be/be an/
> s/made/option made/
> s/to exit/exit/
> s/none zero/non-zero/
> s/now is/is now/
>
> Or in summary:
>
> And change the function argument to be an output stream.  Earlier the
> --help option made kill exit with a non-zero value; that is now corrected.

Thank you Benno, and Q.E.D. my English is rubbish.

Karel, that correction and the earlier fstrim exit code definition
reshuffle can be found from my git. Details for easy merge are below.

--- snip
The following changes since commit 422f93bfbb5df358fad3fedfe9eb0247cbf3cb14:

  include/closestream: don't wipe errno on EPIPE (2014-03-13 12:41:03 +0100)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2014wk09

for you to fetch changes up to 6a02f1dd9639b8b13c318a061951bc7b7a8b8f6e:

  kill: move sigqueue inputs to control struct (2014-03-19 18:57:21 +0000)

----------------------------------------------------------------
Sami Kerola (16):
      build-sys: unify function and variable attribute spacing
      mcookie: use lib/randutils
      mcookie: allow --file option be defined multiple times
      mcookie: use same variable type consistently
      mcookie: use control structure, and fix usage()
      mcookie: add --max-size option
      findfs: use symbolic exit values, and tell about them in manual
      kill: fix coding style
      kill: flip all comparions to be in smaller - greater order
      kill: move magic numbers in beginning of the file
      kill: make usage() not to return
      kill: deprecat invocation as 'pid' command name
      kill: use control structure to pass user input to functions
      kill: tell what is wrong rather than output usage()
      kill: add parse_arguments() function
      kill: move sigqueue inputs to control struct

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
