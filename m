Return-Path: alun.linux@ty-penguin.org.uk
Date: Fri, 7 Dec 2012 12:50:32 +0000
From: Alun <alun.linux@ty-penguin.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: kzak@redhat.com, util-linux@vger.kernel.org
Subject: Re: [PATCH] Add option to fsfreeze to call syncfs() prior to
 freezing.
Message-ID: <20121207125032.6f4a0fea@pcebbj.staff.aber.ac.uk>
In-Reply-To: <20121207124415.GA28504@infradead.org>
References: <20121207101400.5e46ba48@pcebbj.staff.aber.ac.uk>
	<20121207124415.GA28504@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

Christoph Hellwig <hch@infradead.org> said, in message
20121207124415.GA28504@infradead.org:
> 
> It might be better to send a kernel patch to do a first async sync
> attempt instead of band aiding this in one of the consumers.

That's what I did originally - see http://marc.info/?t=135474654500003&r=1&w=2

Cheers,
Alun.

-- 
Alun Jones,    auj@aber.ac.uk,    01970 622494
Gwasanaethau Gwybodaeth / Information Services  
Prifysgol Aberystwyth / Aberystwyth University
