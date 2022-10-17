Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8280C4332F
	for <util-linux@archiver.kernel.org>; Mon, 17 Oct 2022 18:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiJQSIJ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Oct 2022 14:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiJQSII (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 17 Oct 2022 14:08:08 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8FC74BA0
        for <util-linux@vger.kernel.org>; Mon, 17 Oct 2022 11:08:06 -0700 (PDT)
Received: from [192.168.101.10] ([91.12.163.236]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MMXDj-1oS8jU48wx-00JaTw; Mon, 17 Oct 2022 20:08:04 +0200
Message-ID: <20817a7e-9659-a00f-c141-2db0469a4594@bernhard-voelker.de>
Date:   Mon, 17 Oct 2022 20:08:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: Proposal for new column(1) flag
Content-Language: en-US
To:     Thomas Voss <mail@thomasvoss.com>
Cc:     util-linux <util-linux@vger.kernel.org>
References: <CNL1J5PPBA9T.2ZR8EL0OSX1XJ@mango-os>
 <08dd1386-3511-2f1a-b041-0a445d34ae1a@bernhard-voelker.de>
 <CNO4L8IMOGYS.1DZ36WVMXZ8K4@mango-os>
From:   Bernhard Voelker <mail@bernhard-voelker.de>
In-Reply-To: <CNO4L8IMOGYS.1DZ36WVMXZ8K4@mango-os>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:42qLOve79PZFsILKCURPqinRsA023G6ogCMhUFFOGM1DP25PUVj
 WSgFYOAJ+w+6JweHejBTMMKv/Pe6y20pqJAkOhzb4VH1YM25vu4bVURRmMCLsGDg/dmci62
 ivUpSpd19Jgl8HWdDxjarpXFHkKoLeuer+jsZxsgahDQKJw21P/5RUsy4qJmzRN/PWHoW30
 iV6/lZXT7Ru+gnA0yhVCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/y+Fwbbp4eY=:5dHSVLK66vgWNrWV6v6bxw
 gc+XzMcdtw2YkltVHc5TY19A3ZPgwztMcQRzxOqquoKP2mIGkJUoNp4k99G97maYKHU2xaYRQ
 1UmVXfKmkM3korAEdjy1TUcF2P8BPdmUUSvw4x+yz4KytWqLUH+9RnMfuBBnl8REJOVweyQj5
 AGW9Sjhjcg756MHTwXQJXpByZzoC7eG6kpCZR0cnXbSxEWZAJg2OJ5vZSMBPxa3f33Y17zufA
 4kBd+67KrfYhDaihfbuItyVrWqi/qyRVwBBdW91V+c3tKYPpmictIru7jRvtNeEDC2brI/fll
 CtfeupYPCk3Cda00XFfwlN7X4dEf7rT42PKnBL857QHO1PhJ7JL5JZA8IZ3MzMkNup/pa5sop
 i2ma26ghY6MPQusZpzOaPaACtfq1Gf1eiW0eMRUbwK8PZeY6SXO95B1o2Mpu9uW78jUsB2Vso
 ZqgDMiqtdH9KNEOZUnPEGHTWNJanJ1oMySmwZ93CyCWjY1Jk6Arn98hD5EtZ/WrTpWVML3JGz
 oobCAT6QwrXYRhnbXfwYZBtKbNlOytNCAg33ttiyJDDDzB8yIm/w4v3+sulsOemZFUyE6RK9J
 cVIxaq2BUDgHtdn8zhmQjcfLdRMERzjH9AjCpCvgspfUtksA4MrVoq5RDza12gVR04xairM5f
 uql6fyqvYGZnlssv354gL4N5T8rUCTbLhrDoW8kLwJt+ItG/wRlHRKMQHMEV12wAStm434BTo
 DUHhwjz8Ysc9snWd7c5s0jJTUw7rtwDWTF6IV0HjSz3WhonjVloLkpIBcdmDjZ49tK7TMDbGp
 WWlVyrzn4Aw7k5L+49OnGDOi9tEyg==
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

oh, your 2 emails indeed didn't come thru ... I guess because there were 3 attachments.

Hereby forwarding...

On 10/17/22 12:27, Thomas Voss wrote:
> NOTE: Sorry if this email is a duplicate, I have been trying to send this
> for a good while but theres something wrong with my email client
> configuration that I need to try to figure out.
> 
> Also in my first email I made some references to "center", I actually
> meant to say "column", center is just a tool I was writing some code for
> when sending that email so it was stuck in my head.
> 
> ---
> 
> On Thu Oct 13, 2022 at 10:43 PM CEST, Bernhard Voelker wrote:
>> Hmm, you missed to give actual examples.  Is it like the output of
>> this?
>>
>>     $ ls * | column -xc $COLUMNS | column -t
> 
> Not quite, let me give you a real-world example (and the thing that
> prompted me to think of adding this feature).
> 
> I have a simple script on my system that has a list of movies, and I want
> to be able to display them all nicely in columns.  At the moment I am
> doing this, which is not optimal because the gaps between columns are too
> large, it results in 5 columns and 8 rows:
> 
>     $ column -x movie-list
> 
> This is what your suggestion looks like, and it also resuts in 5 columns
> and 8 rows but much more squished together:
> 
>     $ column -xc $COLUMNS movie-list | column -t
> 
> And finally this is a really stupid solution which creates a file for
> each line of the file and then uses ls to print them, it results in 6
> columns and 6 rows, which is more space-efficient, and what I would like
> to be able to get as output:
> 
>     #!/bin/sh
> 
>     while read f; do
>             touch $f
>     done <../movie-list
>     ls *
>     rm *
> 
> The outputs are included in files attached to this email

Have a nice day,
Berny

