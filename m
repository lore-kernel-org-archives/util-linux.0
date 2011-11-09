Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53964 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab1KIKcE convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Nov 2011 05:32:04 -0500
Received: by iage36 with SMTP id e36so1586256iag.19
        for <util-linux@vger.kernel.org>; Wed, 09 Nov 2011 02:32:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPYQg30QdL8evykx4tfiO+K35ZFTuKOVxY_R08nKz5F=-imsVg@mail.gmail.com>
References: <CAPYQg32qP3Xb_gS45Md6ArqJGx22xZUdCg-W4z5f1ji2id7aSA@mail.gmail.com>
	<1320797364.3005.10.camel@offbook>
	<CAPYQg31aC1PDvZGtgtbvLZsLLYKo-SufL-qsDHAU5b+r3eErXQ@mail.gmail.com>
	<20111109092312.GI16397@nb.net.home>
	<CAPYQg30QdL8evykx4tfiO+K35ZFTuKOVxY_R08nKz5F=-imsVg@mail.gmail.com>
Date: Wed, 9 Nov 2011 19:32:02 +0900
Message-ID: <CAPYQg31hpFPkXVjwfALsnsiqikDtWqXavOswfejA-UPXhFzOjA@mail.gmail.com>
Subject: behavior of "# mount /dev"
From: KIMURA Masaru <hiyuh.root@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Oops, gmail remove list address.
Forward for recording the archives.

---------- Forwarded message ----------
From: KIMURA Masaru <hiyuh.root@gmail.com>
Date: 2011/11/9
Subject: Re: behavior of "# mount /dev"
To: Karel Zak <kzak@redhat.com>


>> Summary:
>> - "# mount /dev" hides udev managed /dev.
>> - because it doesn't return a busy error.
>> - because it uses tmpfs.
>> - using tmpfs, we are not able to treat this case as error in kernel.
>
>  Sure, it's not a bug.
>
>  It would be nice to have mount option (VFS flag) to control this behavior,
>  something like:
>
>    # mount -t tmpfs none /dev -o nooverlay
>
>    # mount -t tmpfs none /dev      --> EBUSY

ACK.
Thank you for taking time to check my poor translation.
