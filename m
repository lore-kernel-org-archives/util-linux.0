Return-Path: BATV+8b49371dd9f43e2759e7+3394+infradead.org+hch@bombadil.srs.infradead.org
Date: Sat, 8 Dec 2012 07:47:43 -0500
From: Christoph Hellwig <hch@infradead.org>
To: Alun <alun.linux@ty-penguin.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, kzak@redhat.com,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] Add option to fsfreeze to call syncfs() prior to
 freezing.
Message-ID: <20121208124743.GA18956@infradead.org>
References: <20121207101400.5e46ba48@pcebbj.staff.aber.ac.uk>
 <20121207124415.GA28504@infradead.org>
 <20121207125032.6f4a0fea@pcebbj.staff.aber.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121207125032.6f4a0fea@pcebbj.staff.aber.ac.uk>
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 07, 2012 at 12:50:32PM +0000, Alun wrote:
> Christoph Hellwig <hch@infradead.org> said, in message
> 20121207124415.GA28504@infradead.org:
> > 
> > It might be better to send a kernel patch to do a first async sync
> > attempt instead of band aiding this in one of the consumers.
> 
> That's what I did originally - see http://marc.info/?t=135474654500003&r=1&w=2

So let's keep the discussion there, if you do exactly the same call from
userspace the same arguments still apply.
