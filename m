Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f172.google.com ([209.85.192.172]:55338 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660AbaD2Tke (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 29 Apr 2014 15:40:34 -0400
Received: by mail-pd0-f172.google.com with SMTP id g10so602725pdj.17
        for <util-linux@vger.kernel.org>; Tue, 29 Apr 2014 12:40:33 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1398797443.20719.111805353.31C825B4@webmail.messagingengine.com>
References: <1398797443.20719.111805353.31C825B4@webmail.messagingengine.com>
Date: Tue, 29 Apr 2014 20:40:33 +0100
Message-ID: <CAG27Bk0byyTHWfEz7+HtVx1=-o+4JCnxa3NiW9934=oyFXOnqg@mail.gmail.com>
Subject: Re: [patches] removing some duplicate includes and standardizing a
 usage text
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 29 April 2014 19:50, Benno Schulenberg <bensberg@justemail.net> wrote:
> The first few patches remove two duplicate includes, tweak some
> comments and usage strings, and normalizes another include.
>
> The sixth patch adds a missing error message to ionice.  And as the
> usage text of ionice recently changed, the seventh patch seizes the
> opportunity to slice it up, standardize its form, and improve some
> of the descriptions.
>
> The eighth patch tries to massage the usage howto into a better
> grammatical shape.
>
> Sami, there is one thing I changed: the square brackets around the
> three dots, as that seems pleonastic to me, and the man-pages man page
> suggests the bare three dots: see 'man 1 man' and search for "repeat".

Hi Benno,

You are right. That looks better. Now when you are working with this
maybe the commands and other documents could be fixed in same go.

$ git grep -l '\[\.\.\.\]' *utils lib* Documentation
Documentation/howto-debug.txt
Documentation/howto-usage-function.txt
Documentation/releases/v2.13-ReleaseNotes
disk-utils/sfdisk.c
misc-utils/kill.c
sys-utils/cytune.8
sys-utils/cytune.c
sys-utils/ipcrm.c
sys-utils/losetup.c
text-utils/hexdump.1

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
