Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BC6CDB482
	for <util-linux@archiver.kernel.org>; Thu, 19 Oct 2023 00:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjJSANO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 18 Oct 2023 20:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJSANO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 18 Oct 2023 20:13:14 -0400
X-Greylist: delayed 83746 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Oct 2023 17:13:12 PDT
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9852B124
        for <util-linux@vger.kernel.org>; Wed, 18 Oct 2023 17:13:12 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1697674391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HcCCtt6ieigUNK5irfSNR93DARnBkuChpm6+0lrfcAk=;
        b=YnZsnZTCIRIK7Mme5x331u8YZemaOYX+6pSXutPHsQVY+D7Dj/T67gxJV8rv01K3MeE0KP
        Uvsy+pIzYryUGGfKnXKqOOOc2fCkXdjs6164m3Bc4jjK2EUv1tXWneEOsH/mrYXbFC4qBz
        tqF7nV3iv7cQgZmwOCTtCR/0PMd+Ycp9xWtccpbJmhn2CTKKu/1kvUn9MUrr+ic3JrvUtK
        KP72Qh7v0FDZuj+Z5iXtK/C8ebImadcp56msTs8llk243OxQC5EAPS3HElRPyAJZZ2LUnV
        X/lbQBlKj6G43GVxx2F5nKqKOWyvRXGweJX3gnSgce5gDwZRXb5fjpOOVMbVOQ==
Date:   Thu, 19 Oct 2023 02:13:10 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Karel Zak <kzak@redhat.com>
Cc:     Junxiao Bi <junxiao.bi@oracle.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] loopdev: fix losetup failure with a lost device file
In-Reply-To: <20231018175941.f2zysgnq4ibwoyvl@ws.net.home>
References: <20231012215524.44326-1-junxiao.bi@oracle.com>
 <20231018175941.f2zysgnq4ibwoyvl@ws.net.home>
Message-ID: <f0a016fb4e4319382159a32d474a65ee@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2023-10-18 19:59, Karel Zak wrote:
> On Thu, Oct 12, 2023 at 02:55:24PM -0700, Junxiao Bi wrote:
>> +	sprintf(path, "/dev/loop%d", nr);
>> +	/* default loop device permission is "brw-rw----" */
>> +	umask(0003);
>> +	ret = mknod(path, S_IFBLK|0660, makedev(major, minor));
>> +	if (ret)
>> +		return -1;
> 
> frankly, it will be challenging to convince me that using mknode in a
> tool like losetup is a good idea. After all these decades, it's still
> not a common practice (although I have see many attempts).  Nodes are
> typically created by udevd by default, following udev rules.
> 
> IMHO, it's better to report the problem (perhaps with a helpful hint)
> as error message and assume that the administrator will address it.

Perhaps a separate exit status could also be returned?  By the way, when 
does actually losetup(8) return 2, as described in the man page?  I'm 
having troubles finding the exact place in the source code where that 
happens.
