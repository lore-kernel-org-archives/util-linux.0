Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751931AbdC1MQo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 28 Mar 2017 08:16:44 -0400
Date: Tue, 28 Mar 2017 14:16:30 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: col issue
Message-ID: <20170328121630.prr5s6aikqvt2awt@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

 see https://bugzilla.redhat.com/show_bug.cgi?id=1436432

 any idea what is the right col(1) behavior for escape sequences?

 The current code reads two first bytes from the sequence and the rest
 is interpreted as standard chars (because complex sequences like
 ^[..m are completely unknown for the code), for example input:

    ^[[1mtomcat-el^[(B^[[m

 produces:

    1mtomcat-elBm

 It seems incorrect. I think for "col -p" all the sequence should be
 filtered out, it means:
   
    tomcat-el
 
 and the default behavior (without -p) should be output all escape
 sequences but do not increment internal width counters.
 
 Objections?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
