Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.asbjorn.biz ([185.38.24.25]:44596 "EHLO mail.asbjorn.biz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeIZDCx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 25 Sep 2018 23:02:53 -0400
Subject: Re: [PATCH 2/2] script: add input log feature
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20180819171658.20285-1-asbjorn@asbjorn.st>
 <20180819171658.20285-2-asbjorn@asbjorn.st>
 <20180820084650.xpit6acizkqt56qs@ws.net.home>
From: =?UTF-8?Q?Asbj=c3=b8rn_Sloth_T=c3=b8nnesen?= <asbjorn@asbjorn.st>
Message-ID: <2502ef5d-dc46-d2d3-5449-070df0e58a37@asbjorn.st>
Date: Tue, 25 Sep 2018 20:44:47 +0000
MIME-Version: 1.0
In-Reply-To: <20180820084650.xpit6acizkqt56qs@ws.net.home>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

On 08/20/2018 08:46 AM, Karel Zak wrote:
> On Sun, Aug 19, 2018 at 05:16:58PM +0000, Asbjørn Sloth Tønnesen wrote:
>> When script is used to log usage of shell accounts, accessible by
>> random users (some of whom might be malicious).
>>
>> This patch adds a new --input-log option, which makes script save
>> the input data to a file, in an extended timing format also containing
>> the data, thereby allowing the input to be reconstructed.
> 
> I like the feature, but not sure if we really need to introduce a new
> log format specific to the input stream.
> 
> For long time I think about a new timing file format. Maybe we can add
> support for new timing file format where will be possible log
> information about more streams (stdin and stdout) and events (for
> example signals).

I am working on implementing this, expect patches soon.

I am implementing 2 new formats, so we will have:
- classic - like now, with 1-2 output files
- new - like you described, with 2-3 output files
- combined - with a single output file

I am also adding support for both new formats to scriptreplay.

-- 
Best regards
Asbjørn Sloth Tønnesen
