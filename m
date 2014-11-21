Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:36447 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbaKUHro (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 21 Nov 2014 02:47:44 -0500
Received: by mail-wg0-f48.google.com with SMTP id y19so5759132wgg.7
        for <util-linux@vger.kernel.org>; Thu, 20 Nov 2014 23:47:42 -0800 (PST)
Message-ID: <546EEE1C.102@gmail.com>
Date: Fri, 21 Nov 2014 08:47:40 +0100
From: Milan Broz <gmazyland@gmail.com>
MIME-Version: 1.0
To: "Dale R. Worley" <worley@alum.mit.edu>,
        Drake Wilson <drake@dasyatidae.net>
CC: util-linux@vger.kernel.org
Subject: Re: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net> <201411192224.sAJMOhTi010782@hobgoblin.ariadne.com> <546D1BA7.9060501@dasyatidae.net> <201411202133.sAKLXSZP006667@hobgoblin.ariadne.com>
In-Reply-To: <201411202133.sAKLXSZP006667@hobgoblin.ariadne.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11/20/2014 10:33 PM, Dale R. Worley wrote:
>> From: Drake Wilson <drake@dasyatidae.net>
> 
>> I might support an extension
>> proposal to allow (but not require) a type for the underlying volume to
>> be added as part of the _LUKS_ header, therefore (probably using a GPT
>> type just for convenience).
> 
> That sounds like a better proposal to me.  But I have no idea whether
> LUKS can support such an extension.

If I understand it correctly, you want to duplicate some UUID stored
in LUKS container payload to LUKS header?

LUKS will not support such extension. For two reasons:

- there is a clear layer separation, LUKS handle block layer encryption,
treating container data as a block device. It doesn't care about any
signatures or whatever is contained in data.
This information can be stored elsewhere (UUID in fstab of underlying device,
for example) but not in the LUKS header.

- for security reasons: if you add visible UUID of data inside container,
now you have definitely at least part of plaintext/ciphertext pair
available for attacker (UUID is stored on fixed offset).

Not that it makes possible ciphertext modification attacks to devices without
integrity protection much worse... but use this concept as a design decision
in a security tool would be just ridiculous.

Milan
