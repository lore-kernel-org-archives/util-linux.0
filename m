Return-Path: util-linux-owner@vger.kernel.org
Received: from sender153-mail.zoho.com ([74.201.84.153]:22687 "EHLO
	sender153-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760441AbcCDXuL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 4 Mar 2016 18:50:11 -0500
Message-ID: <56DA1F2A.5040104@zoho.com>
Date: Sat, 05 Mar 2016 00:50:02 +0100
From: =?UTF-8?B?w4FuZ2VsIEdvbnrDoWxleg==?= <ingenit@zoho.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
CC: up201407890@alunos.dcc.fc.up.pt, Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: Fixing su + runuser vulnerability CVE-2016-2779
References: <56D7409A.6050407@suse.cz> <20160303013722.22156xdxrqmywgw0@webmail.alunos.dcc.fc.up.pt> <56D8648F.60504@suse.cz> <56D9B445.5080808@suse.cz> <20160304190312.17036kwlv8g5ydk4@webmail.alunos.dcc.fc.up.pt>
In-Reply-To: <20160304190312.17036kwlv8g5ydk4@webmail.alunos.dcc.fc.up.pt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I was thinking about this and the problem is actually that runuser 
returns (and control is returned to the privileged parent) while there's 
an unprivileged descendant with a handle to the tty.
Thus, it seems that it could be solved by having runuser run the child 
into a new cgroup and refusing to return while there's any remaining 
process there.


Although depending on the exact way that people is expecting to use job 
control, that might still interefere despite not changing the session 
leader. Do we know actual usages that should continue working?

Regards

