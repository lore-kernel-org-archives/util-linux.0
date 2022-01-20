Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51585C433EF
	for <util-linux@archiver.kernel.org>; Thu, 20 Jan 2022 13:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiATNrM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 20 Jan 2022 08:47:12 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:60671 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbiATNrM (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 20 Jan 2022 08:47:12 -0500
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20KDl0nP044385;
        Thu, 20 Jan 2022 22:47:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Thu, 20 Jan 2022 22:47:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20KDl0il044377
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Jan 2022 22:47:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a0ec54b9-869f-15e3-4b0c-4c922d120b40@I-love.SAKURA.ne.jp>
Date:   Thu, 20 Jan 2022 22:46:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mount: Fix race in loop device reuse code
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <20220120114705.25342-1-jack@suse.cz>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220120114705.25342-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2022/01/20 20:47, Jan Kara wrote:
> Fix the problem by rechecking that loop device is still attached after
> opening the device. This makes sure the kernel will not autoclear the
> device anymore.

Since this block is marked as /* overlap -- full size and offset match (reuse) */ ,
can just checking that neither loopcxt_get_fd() nor loopcxt_get_info() failed guarantee
that full size and offset still match? Isn't there possibility that autoclear of file1
completes and another thread again assigns file2 (with different size or offset) right
before /* Open loop device to block device autoclear... */ line? Don't we need to
compare with more robust identifier like device:inode pair?

