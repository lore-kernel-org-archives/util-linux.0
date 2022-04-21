Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34FAC433F5
	for <util-linux@archiver.kernel.org>; Thu, 21 Apr 2022 13:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385428AbiDUNdk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385501AbiDUNdf (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 21 Apr 2022 09:33:35 -0400
Received: from correo.48k.eu (correo.48k.eu [217.70.190.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E95718340
        for <util-linux@vger.kernel.org>; Thu, 21 Apr 2022 06:30:44 -0700 (PDT)
Message-ID: <e0c723d8-59f9-61b7-557c-5613c297e7af@soleta.eu>
Date:   Thu, 21 Apr 2022 15:30:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: libfdisk python bindings
Content-Language: en-US
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <f0103dd3-870c-5ece-7490-12d927cdaefd@soleta.eu>
 <20220411081504.izsddsnb4m3uguf5@ws.net.home>
From:   "Jose M. Guisado" <jguisado@soleta.eu>
In-Reply-To: <20220411081504.izsddsnb4m3uguf5@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 11/4/22 10:15, Karel Zak wrote:
> On Wed, Apr 06, 2022 at 04:24:34PM +0200, Jose M. Guisado wrote:
>> Hi, recently I've started working on python bindings for libfdisk. Just
>> a C extension for CPython, like the libmount python bindings.
>>
>> Early WIP can be found at https://github.com/pvxe/python-libfdisk/
>>
>> After reading the mailing list archive and previous github issues
>> related to python bindings, I'm wondering if patches would be accepted,
>> or python bindings are preferred separate from the util-linux tree.
> 
> Frankly, I'm not sure if adding bindings to the project is good.
> 
> We already have libmount there, and it is terrible. It is not up to
> date with the original libmount library, it requires some additional
> stuff in the build system, extra dependencies, etc., and I have no
> time to fix it. (So, my long-term plan is to mark it as obsolete and
> remove it from the project.)
> 
> That's the reason why libsmartcols python binding has been maintained
> out of the tree, and it would be probably better also for libfdisk.

Makes sense. :-)

> If you plan to maintain the python binding, we can help you propagate
> your project (in util-linux Release Notes, docs, ...).
> 

That would be my intention, bindings are still in a very early stage of 
development but the moment they are in some more usable shape I would 
let you know.

Thank you for your time Karel.

