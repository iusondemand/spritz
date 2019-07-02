from config import db

from sqlalchemy import Column, ForeignKey, Integer, String, DateTime
from sqlalchemy import Sequence,UniqueConstraint,PrimaryKeyConstraint,ForeignKeyConstraint
from sqlalchemy.orm import relationship


class VotingUser(db.Model):
    __tablename__ = 'votinguser'
    user_id = Column(Integer, Sequence('user_id_seq'), primary_key=True)
    user_name = Column(String(200), unique=True, nullable=False)
    pass_word = Column(String(200), nullable=False)


class Votation(db.Model):
    __tablename__ = 'votation'
    votation_id = Column(Integer, Sequence('votation_id_seq'), primary_key=True)
    promoter_user_id = Column(Integer, ForeignKey('votinguser.user_id'))
    promoter_user = relationship(VotingUser)
    votation_description = Column(String(500),nullable=False,unique=True)
    description_url = Column(String(500),nullable=False, default="")
    begin_date = Column(DateTime(),nullable=False)
    end_date = Column(DateTime(),nullable=False)
    votation_type = Column(String(10),nullable=False, default='simple')
    votation_status = Column(Integer,nullable=False, default=0)
    list_voters = Column(Integer,nullable=False, default=0)

class Option(db.Model):
    __tablename__ = 'option'
    __table_args__ = (UniqueConstraint('votation_id','option_name'),)
    option_id = Column(Integer, Sequence('option_id_seq'), primary_key=True)
    votation_id = Column(Integer, ForeignKey('votation.votation_id'))
    votation = relationship(Votation)
    option_name = Column(String(50),nullable=False)
    description = Column(String(250),nullable=False, default="")

class Vote(db.Model):
    __tablename__ = 'vote'
    __table_args__ = (PrimaryKeyConstraint('vote_key','votation_id','option_id'), )
                    #   ForeignKeyConstraint(['option_id','votation_id'], \
                    #                        ['option.votation_id','option.option_id']))
    vote_key = Column(String(128))
    votation_id = Column(Integer,ForeignKey('votation.votation_id'),nullable=False)
    votation = relationship(Votation)
    option_id = Column(Integer,ForeignKey('option.option_id'),nullable=False)
    option = relationship(Option)
    jud_value = Column(Integer, nullable=False)
    
class Voter(db.Model):
    __tablename__ = 'voter'
    __table_args__ = (PrimaryKeyConstraint('user_id','votation_id'), )
    user_id = Column(Integer, ForeignKey('votinguser.user_id'))
    user = relationship(VotingUser)
    votation_id = Column(Integer,ForeignKey('votation.votation_id'),nullable=False)
    votation = relationship(Votation)
    voted = Column(Integer)
