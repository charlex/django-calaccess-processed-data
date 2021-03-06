#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Proxy models for augmenting our source data tables with methods useful for processing.
"""
from .candidates import (
    ScrapedCandidateProxy,
    ScrapedIncumbentProxy,
)
from .candidateelections import (
    ScrapedCandidateElectionProxy,
    ScrapedIncumbentElectionProxy,
)
from .propositions import ScrapedPropositionProxy
from .propositionelections import ScrapedPropositionElectionProxy


__all__ = (
    'ScrapedCandidateProxy',
    'ScrapedCandidateElectionProxy',
    'ScrapedIncumbentProxy',
    'ScrapedIncumbentElectionProxy',
    'ScrapedPropositionProxy',
    'ScrapedPropositionElectionProxy',
)
