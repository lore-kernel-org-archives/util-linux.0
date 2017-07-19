Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([217.72.192.75]:61125 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751376AbdGSGTE (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 19 Jul 2017 02:19:04 -0400
Subject: Re: [PATCH] setpriv: support setting unnamed capabilities
To: Patrick Steinhardt <ps@pks.im>, util-linux@vger.kernel.org
References: <4ae084e6a1c46726a24057c71d20787680fa3da1.1500326001.git.ps@pks.im>
Cc: kzak@redhat.com
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <2105c6b6-3574-be3c-3f2a-e951e6d8e61d@bernhard-voelker.de>
Date: Wed, 19 Jul 2017 08:18:55 +0200
MIME-Version: 1.0
In-Reply-To: <4ae084e6a1c46726a24057c71d20787680fa3da1.1500326001.git.ps@pks.im>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 07/17/2017 11:14 PM, Patrick Steinhardt wrote:
> When setting capabilities, we accept human readable names like for
> example `sys_rawio` or `net_admin`. To do so the translation between the
> capability name and its in-kernel index, we rely on the function
> `capng_name_to_capability`. When the function does not know the named
> capability, it will return an error value and we abort setting the
> capability.
> 
> This relies upon the ability of libcap to know all capabilities inside
> of the kernel. But actually, it is possible that new capabilities are
> introduced inside of the Linux kernel which are not recognized yet by
> the library. When dumping these unknown capabilities, libcap will simply
> return a string like "cap_38", that is it will append the capability's
> in-kernel index to the prefix "cap_". This may lead a user to also think
> that "cap_38" may be passed to the switches "--inh-caps" or
> "--ambient-caps", which is unfortunately not the case.
> 
> We can do better here by instead accepting strings in the form of
> "cap_N". To do so, we can simply rely on the fact that capability
> indices are steadily increasing and that the highest index known to the
> kernel is stored inside of the kernel's procfs, made readily available
> by our function `real_cap_last_cap()`. So in case libcap does not know a
> capability name, we can simply parse the string and, if it is in the
> correct format, check whether the detected index is between 0 and the
> highest capability index. If so, we can treat it as a valid capability
> string and apply it.

Thanks - would you mind to also add a sentence to the man page?

Thanks & have a nice day,
Berny
