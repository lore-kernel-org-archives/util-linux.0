Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35413 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756340AbcJMUT1 (ORCPT
        <rfc822;util-linux-ng@vger.kernel.org>);
        Thu, 13 Oct 2016 16:19:27 -0400
Received: by mail-lf0-f42.google.com with SMTP id l131so113796672lfl.2
        for <util-linux-ng@vger.kernel.org>; Thu, 13 Oct 2016 13:19:26 -0700 (PDT)
Received: from [192.168.0.123] (84-114-93-119.cable.dynamic.surfer.at. [84.114.93.119])
        by smtp.googlemail.com with ESMTPSA id 187sm4286990ljj.4.2016.10.13.13.19.23
        for <util-linux-ng@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Oct 2016 13:19:23 -0700 (PDT)
Subject: Re: more(1) may attempt to tcsetattr(3) despite lacking controlling
 terminal
To: util-linux-ng@vger.kernel.org
References: <20161013143932.GA29451@netmeister.org>
 <57FFDCFA.4070407@gmail.com>
From: Jakob Unterwurzacher <jakobunt@gmail.com>
Message-ID: <56b4e9fb-a01d-3578-b739-66b7b933a8c5@gmail.com>
Date: Thu, 13 Oct 2016 22:18:29 +0200
MIME-Version: 1.0
In-Reply-To: <57FFDCFA.4070407@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 13.10.2016 21:14, Bruce Dubbs wrote:
>>
>> The following example illustrates the issue:
>>
>> $ /bin/sh -c "timeout 60 /bin/sh -c \"ls | more\""
>>
>> This command will now hang until the timeout, since the shell, ls(1) and
>> more(1) commands invoked by timeout(1) will be suspended.
> 
> It does not hang for me, but then I don't use systemd.  Perhaps systemd should
> be fixed.

Does not hang for me either on Fedora 24, and I am using systemd, but how is
this related to the init system

